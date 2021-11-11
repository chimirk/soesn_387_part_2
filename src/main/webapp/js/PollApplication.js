let choiceCounter=document.getElementById("choice-list").children.length-1

window.addEventListener("load", function() {

    document.getElementById("add").addEventListener("click", function(event) {
        event.preventDefault()
        choiceCounter++;
        // Create a div
        let div = document.createElement("div");
        div.setAttribute("class", "form-group mb-3");
        //Create a label
        let choiceNumber = choiceCounter+1
        let label = document.createElement("label")
        label.setAttribute("class", "control-label fs-4 me-2");
        label.innerText="Choice "+choiceNumber

        //create close button
        let closeButton = document.createElement("button");
        closeButton.setAttribute("type", "button");
        closeButton.setAttribute("class","btn-close");
        closeButton.setAttribute("aria-label", "Close");
        closeButton.setAttribute("value", choiceCounter)
        closeButton.addEventListener("click", removeChoice)

        // Create a input text field
        let textInput = document.createElement("input");
        textInput.setAttribute("type", "text");
        textInput.setAttribute("name", "choice_text");
        textInput.setAttribute("class","form-control m-1")
        textInput.setAttribute("placeholder", "Enter Text")
        textInput.setAttribute("required", "true")

        // Create a input description
        let descriptionInput = document.createElement("input");
        descriptionInput.setAttribute("type", "text");
        descriptionInput.setAttribute("name", "description");
        descriptionInput.setAttribute("class","form-control m-1")
        descriptionInput.setAttribute("placeholder", "Enter Description")
        descriptionInput.setAttribute("required", "true")


        // add the file and text to the div
        div.appendChild(label)
        div.appendChild(closeButton)
        div.appendChild(textInput)
        div.appendChild(descriptionInput)

        //Append the div to the container div
        document.getElementById("choice-list").appendChild(div);

    });
});

function removeChoice(event){
    let index = Number(event.target.getAttribute("value"))
    let choiceList = document.getElementById("choice-list")
    choiceList.children[index].remove()
    for (let i = index; i < choiceList.children.length; i++) {
        let div = choiceList.children[index]
        let label = div.children[0]
        let closeButton = div.children[1]
        let choiceNumber = i+1
        label.innerText = "Choice "+choiceNumber
        closeButton.setAttribute("value", i)
    }
    choiceCounter--
}