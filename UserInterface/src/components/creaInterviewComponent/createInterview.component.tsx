import * as React from 'react';
import { RouteComponentProps } from 'react-router-dom';
import { connect } from 'react-redux';
//import { toast } from 'react-toastify';
import { withRouter } from "react-router";
import { InputGroupAddon, Form } from 'reactstrap';
import Input from 'reactstrap/lib/Input';
import InputGroup from 'reactstrap/lib/InputGroup';
import './createInterview.component.scss';
import { setState } from '../../actions/createInterview/createInterview.actions';
import Button from 'reactstrap/lib/Button';
import { INewInterviewData } from '../../model/INewInterviewData';
import { ICreateInterviewComponentState } from '../../reducers/interview';
import { cohortClient } from '../../axios/sms-clients/cohort-client';
import { userClient } from '../../axios/sms-clients/user-client';
import { IState } from '../../reducers';
import { interviewClient } from '../../axios/sms-clients/interview-client';
import { Client } from '../../model/Client.model';


interface ICreateInterviewComponentProps extends RouteComponentProps {
    createInterviewComponentState: ICreateInterviewComponentState;
    setState: (newCreateInterviewComponentState: ICreateInterviewComponentState) => void;
}

class CreateInterviewComponent extends React.Component<ICreateInterviewComponentProps> {

    componentDidMount() {
        cohortClient.findAll().then((res) => {
            if (res.data) {
                this.props.setState({ ...this.props.createInterviewComponentState, allCohorts: res.data })
            }
            console.log("all cohorts");
            console.log(res);
        }).catch((e) => {
            console.trace();
            console.log(e);
        });
        this.getAllClients();
    }

    getAllClients = async () => {
        let tempArr = await interviewClient.fetchClient();
        let clientArr: Client[] = await tempArr.data;

        this.props.setState({ ...this.props.createInterviewComponentState, clientArr: clientArr });

        console.log(this.props.createInterviewComponentState.clientArr);
    }

    fetchAssociatesInSelectedCohort = async (selectedCohort) => {
        //const selectedCohort = this.props.createInterviewComponentState.selectedCohort;
        console.log("selected cohort");
        console.log(selectedCohort);
        const res = selectedCohort && await userClient.findAllByCohortId(selectedCohort.cohortId);
        if (res && res.data) {
            this.props.setState({
                ...this.props.createInterviewComponentState,
                associatesInSelectedCohort: res.data,
                selectedAssociate: undefined,
            })
        }
        console.log("all associates in cohort");
        console.log(res);
    }

    sendInputToDB = async (): Promise<boolean> => {
        let { selectedAssociate, date: dateString, location, client } = this.props.createInterviewComponentState; // { firstName:'', lastName:'', date:'', location:'', format:''}
        if (selectedAssociate && dateString && location && client) {
            const newInterviewData: INewInterviewData = {
                associateEmail: selectedAssociate.email,
                date: (new Date(dateString)).valueOf(),
                location: location,
                client: client
            };
            console.log(newInterviewData);
            const res = await interviewClient.addNewInterview(newInterviewData)
            console.log('submitted')
            console.log(res);
            return (res.status >= 200 && res.status < 300); 
        } else return false;
    }

    render() {
        // private int associateId;	
        // private Date scheduled; 
        // private String Place;
        // private int interview_format;
        // private int managerId;
        
        const state = this.props.createInterviewComponentState;
        const setState = this.props.setState;
        const { allCohorts, selectedCohort, associatesInSelectedCohort, selectedAssociate, date, location, client } = state; // { firstName:'', lastName:'', date:'', location:'', format:''}
        const cohortOptions = allCohorts && allCohorts.map((val) => { return <option value={JSON.stringify(val)}>{val.cohortName}</option> })
        const associateOptions = associatesInSelectedCohort && associatesInSelectedCohort.map((val) => { return <option value={JSON.stringify(val)}>{`${val.firstName} ${val.lastName}`}</option> })
        const buttonDisabledState = !(selectedAssociate && date && location && client);
        const buttonText = (buttonDisabledState)? "Please fill out all fields" : "SUBMIT";
        const buttonOnClick = async ()=>{const success = await this.sendInputToDB(); console.log("successfully sent?:" + success); if(success)this.props.history.push("/interview/list");};
        
        return (
            <div id='new-interview-full'>
                <span>CREATE A NEW INTERVIEW FOR AN ASSOCIATE</span>
                <hr />
                <Form>
                    <InputGroup>
                        <Input type='select' value={JSON.stringify(selectedCohort)} disabled={!allCohorts || allCohorts.length == 0} onChange={(e: React.ChangeEvent<HTMLInputElement>) => { setState({ ...state, selectedCohort: JSON.parse(e.target.value), selectedAssociate: undefined }); this.fetchAssociatesInSelectedCohort( JSON.parse(e.target.value)); }} >
                            <option value={undefined} style={{ display: 'none' }}>select a cohort...</option>
                            {cohortOptions}
                        </Input>
                        <Input type='select' value={selectedAssociate ? JSON.stringify(selectedAssociate) : ''} disabled={!associatesInSelectedCohort || associatesInSelectedCohort.length == 0} onChange={(e: React.ChangeEvent<HTMLInputElement>) => { setState({ ...state, selectedAssociate: JSON.parse(e.target.value) }); }} >
                            <option value={undefined} style={{ display: 'none' }}>select an associate...</option>
                            {associateOptions}
                        </Input>
                    </InputGroup>
                    <InputGroup>
                        <Input placeholder="" disabled={true} value={selectedAssociate ? `${selectedAssociate.firstName} ${selectedAssociate.lastName}` : ''} />
                    </InputGroup>
                    < br />
                    <InputGroup>
                        <InputGroupAddon addonType="prepend">date</InputGroupAddon>
                        <Input type="date" placeholder="date" value={date} onChange={(e: React.ChangeEvent<HTMLInputElement>) => { setState({ ...state, date: e.target.value }); }} />
                    </InputGroup>
                    < br />
                    <InputGroup>
                        <InputGroupAddon addonType="prepend">location</InputGroupAddon>
                        <Input placeholder="enter location of interview" value={location} onChange={(e) => { setState({ ...state, location: e.target.value }) }} />
                    </InputGroup>
                    < br />
                    <InputGroup>
                        <InputGroupAddon addonType="prepend">client</InputGroupAddon>
                        <Input type="text" placeholder="enter or select client name" list="clients" value={client} onChange={(e) => { setState({ ...state, client: e.target.value }) }} />
                            <datalist id="clients">
                                {this.props.createInterviewComponentState.clientArr.map((ele: any) => (
                                    <option value={ele.clientName} />
                                ))}
                            </datalist>
                    </InputGroup>
                    < br />
                    <Button color="secondary" size="lg" block disabled={buttonDisabledState} onClick={buttonOnClick}>{buttonText}</Button>
                </Form>
            </div>
        );
    }


}

const mapStateToProps = (state: IState) => ({
    createInterviewComponentState: state.interviewState.createInterviewComponentState
});
const mapDispatchToProps = {
    setState: setState
}
export default withRouter(connect(mapStateToProps, mapDispatchToProps)(CreateInterviewComponent));