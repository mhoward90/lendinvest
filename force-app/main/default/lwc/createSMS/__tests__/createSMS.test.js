import { createElement } from "lwc";
import CreateSMS from "c/CreateSMS";
import { getRecord } from "lightning/uiRecordApi";

const mockGetRecord = require("./data/getRecord.json");

async function flushPromises() {
  return Promise.resolve();
}

describe("c-create-sms", () => {
  let element;

  beforeEach(() => {
    element = createElement("c-create-sms", {
      is: CreateSMS
    });
    document.body.appendChild(element);
  });

  afterEach(() => {
    // The jsdom instance is shared across test cases in a single file so reset the DOM
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
  });

  it("should display the input components", async () => {
    getRecord.emit(mockGetRecord);
    await flushPromises();

    const phoneNumber = element.shadowRoot.querySelector(
      "lightning-formatted-phone"
    );
    const textArea = element.shadowRoot.querySelector("lightning-textarea");
    const sendButton = element.shadowRoot.querySelector("lightning-button");

    expect(textArea).not.toBeNull();
    expect(sendButton).not.toBeNull();
    expect(phoneNumber.value).toBe("+4487917283123");
  });

  it("should update the number of characters remaining", async () => {
    getRecord.emit(mockGetRecord);
    await flushPromises();

    let textArea = element.shadowRoot.querySelector("lightning-textarea");
    textArea.value =
      "I have written some text to reduce the number of characters remaining";
    textArea.dispatchEvent(new CustomEvent("change"));

    await flushPromises();
    const remainingText = element.shadowRoot.querySelector(
      '[data-id="remaining_characters"]'
    );
    expect(remainingText.textContent).toBe(
      "Number of characters remaining:91"
    );
  });
});
