import { LightningElement } from 'lwc';

export default class CreateSMS extends LightningElement {
  sendSms(event) {
    const smsBody = this.template.querySelector('lightning-textarea').value;
  }
}