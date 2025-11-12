// Get references to the essential HTML elements
const inputBox = document.getElementById("input-box");
const listContainer = document.getElementById("list-container");

/**
 * Adds a new task to the list.
 */
function addTask() {
    // Check if the input box is empty
    if (inputBox.value === '') {
        alert("You must write something!");
    } else {
        // Create a new list item (li)
        let li = document.createElement("li");
        li.innerHTML = inputBox.value;
        listContainer.appendChild(li);

        // Create a delete button (span) for the new task
        let span = document.createElement("span");
        span.innerHTML = "\u00d7"; // This is the '×' character
        li.appendChild(span);
    }
    // Clear the input box after adding the task
    inputBox.value = "";
    saveData(); // Save the updated list to localStorage
}

// Add an event listener to the list container to handle clicks
listContainer.addEventListener("click", function(e) {
    // If a list item (LI) is clicked, toggle its 'checked' class
    if (e.target.tagName === "LI") {
        e.target.classList.toggle("checked");
        saveData(); // Save the state
    }
    // If a delete button (SPAN) is clicked, remove its parent list item
    else if (e.target.tagName === "SPAN") {
        e.target.parentElement.remove();
        saveData(); // Save the state
    }
}, false);


/**
 * Saves the current state of the to-do list to the browser's localStorage.
 */
function saveData() {
    localStorage.setItem("data", listContainer.innerHTML);
}

/**
 * Retrieves and displays the to-do list from localStorage when the page loads.
 */
function showTask() {
    listContainer.innerHTML = localStorage.getItem("data");
}

// Load the tasks when the page is first opened
showTask();
