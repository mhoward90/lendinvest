import { LightningElement, wire, api } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import PHONE_FIELD from "@salesforce/schema/Account.Phone";
import sendSmsMessage from "@salesforce/apex/CommunicationsController.sendSmsMessage";

export default class CreateSMS extends LightningElement {
  @api recordId;

  error;
  remainingCharacters = 160;
  accountPhoneNumber;

  @wire(getRecord, { recordId: "$recordId", fields: [PHONE_FIELD] })
  wireRecord({ error, data }) {
    if (data) {
      this.accountPhoneNumber = getFieldValue(data, PHONE_FIELD);
    } else if (error) {
      this.error = error;
    }
  }

  async sendSms(event) {
    const textArea = this.template.querySelector("lightning-textarea");
    if (!textArea.checkValidity()) {
      textArea.reportValidity();
      return;
    }

    const smsBody = this.template.querySelector("lightning-textarea").value;

    try {
      await sendSmsMessage({ messageBody: smsBody, to: "12345667789" });
      showNotification(
        "SMS Successfully Sent",
        `SMS message has been sent to ${to}`,
        "success"
      );
    } catch (e) {
      this.error = e.body.message;
    }
  }

  handleTextChange(event) {
    this.remainingCharacters = 160 - event.target.value.length;
  }

  showNotification(title, message, variant) {
    const evt = new ShowToastEvent({
      title: title,
      message: message,
      variant: variant
    });
    this.dispatchEvent(evt);
  }
}
