import { createElement } from 'lwc';
import CreateSMS from 'c/CreateSMS';

async function flushPromises() {
  return Promise.resolve();
}

describe('c-create-sms', () => {
  beforeEach(() => {
    const element = createElement('c-create-sms', {
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

  it('should display the input component', async () => {
    const textArea = element.shadowRoot.querySelector('lightning-textarea');
    const sendButton = element.shadowRoot.querySelector('lightning-button');

    expect(textArea).not.toBeNull();
    expect(sendButton).not.toBeNull();
  });

  it('should restrict the text input to 160 characters max', async () => {
    let textArea = element.shadowRoot.querySelector('lightning-textarea');
    textArea.value = '12321312';
    element.shadowRoot.querySelector('lightning-button').dispatchEvent(new CustomEvent('click'));

    await flushPromises();
    
  });
});