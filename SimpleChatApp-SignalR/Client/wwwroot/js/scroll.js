window.ScrollToBottom = (elementName) => {
    let element = document.getElementById(elementName);
    if(element === null)
    {
        return;
    }
    element.scrollTop = element.scrollHeight - element.clientHeight;
}