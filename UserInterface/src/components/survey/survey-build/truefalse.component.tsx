import React from 'react';

export class TrueFalse extends React.Component<any, any> {
  constructor(props) {
    super(props);


  }

  render() {

    return (

      <div>
        <label htmlFor="" style={{ marginBottom: 0, textAlign: 'center' }} id="tf" className="form-control" > True/False </label>

        <div className="new" id="t7">

          <input name="questionText" type="text" placeholder="Question Title (i.e. The sky is blue) " style={{ width: '100%' }}   ></input>
          <input name="answerText" value="True,False" readOnly hidden />
        </div>

        <hr />
      </div>

    );
  }
}


export default TrueFalse;