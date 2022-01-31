import { LightningElement } from 'lwc';
import sendSmsMessage from '@salesforce/apex/CommunicationsController.sendSmsMessage';

export default class CreateSMS extends LightningElement {
  error;
  remainingCharacters = 160;

  sendSms() {
    const smsBody = this.template.querySelector('lightning-textarea').value;

    try {
      sendSmsMessage({messageBody: smsBody, toNumber: '', fromNumber: ''});
    } catch (e) {
      this.error = e.message;
    }
  }

  handleTextChange(event) {
    this.remainingCharacters = 160 - event.detail.value.length;
  }
}