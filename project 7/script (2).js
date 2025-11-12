let array = new Array(8).fill(null);
let secretPattern = [];
let timer = 60;
let timerInterval;

function init() {
  generateSecretPattern();
  renderArray();
  startTimer();
  setFeedback(`Find this pattern: ${secretPattern.join(", ")}`);
}

function renderArray() {
  const container = document.getElementById("array");
  container.innerHTML = "";
  array.forEach((val, idx) => {
    const cell = document.createElement("div");
    cell.className = "cell";
    cell.textContent = val !== null ? val : "";
    container.appendChild(cell);
  });
}

function insert() {
  const index = parseInt(document.getElementById("index").value);
  const value = parseInt(document.getElementById("value").value);
  if (isNaN(index) || index < 0 || index >= array.length) {
    return setFeedback("Index out of bounds!");
  }
  if (isNaN(value) || value < 0 || value > 9) {
    return setFeedback("Enter a valid digit (0–9).");
  }
  for (let i = array.length - 1; i > index; i--) {
    array[i] = array[i - 1];
  }
  array[index] = value;
  setFeedback(`Inserted ${value} at index ${index}!`);
  renderArray();
}

function deleteAt() {
  const index = parseInt(document.getElementById("index").value);
  if (isNaN(index) || index < 0 || index >= array.length) {
    return setFeedback("Index out of bounds!");
  }
  for (let i = index; i < array.length - 1; i++) {
    array[i] = array[i + 1];
  }
  array[array.length - 1] = null;
  setFeedback(`Deleted element at index ${index}.`);
  renderArray();
}

function searchPattern() {
  const patternStr = document.getElementById("pattern").value.trim();
  if (!patternStr) return setFeedback("Enter a valid pattern (e.g., 1,2,3)");
  const pattern = patternStr.split(",").map(Number);

  for (let i = 0; i <= array.length - pattern.length; i++) {
    let match = true;
    for (let j = 0; j < pattern.length; j++) {
      if (array[i + j] !== pattern[j]) {
        match = false;
        break;
      }
    }
    if (match) {
      highlightPattern(i, pattern.length);
      setFeedback("Pattern found! Level Complete!");
      clearInterval(timerInterval);
      return;
    }
  }
  setFeedback("Pattern not found!");
}

function highlightPattern(start, length) {
  const cells = document.querySelectorAll(".cell");
  for (let i = start; i < start + length; i++) {
    cells[i].classList.add("highlight");
  }
}

function resetGame() {
  array.fill(null);
  generateSecretPattern();
  renderArray();
  setFeedback("Game reset! New pattern generated.");
  resetTimer();
}

function generateSecretPattern() {
  secretPattern = Array.from({ length: 3 }, () => Math.floor(Math.random() * 10));
}

function setFeedback(msg) {
  document.getElementById("feedback").textContent = msg;
}

function startTimer() {
  timer = 60;
  timerInterval = setInterval(() => {
    timer--;
    document.getElementById("timer").textContent = `Time: ${timer}s`;
    if (timer <= 0) {
      clearInterval(timerInterval);
      setFeedback("Time's up! Mission failed.");
    }
  }, 1000);
}

function resetTimer() {
  clearInterval(timerInterval);
  startTimer();
}

window.onload = init;