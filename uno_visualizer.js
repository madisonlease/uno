// Create a new window
var popup = window.open("", "popup", "width=450,height=200");
const deck = Deck
const url1 = 'https://media.istockphoto.com/id/485651937/photo/deck-of-uno-game-cards.jpg?s=612x612&w=0&k=20&c=UPAkLRxdHVyVyXJOW55iA-_Fg21BSIaZRVci-SOBx9c=' 
function make_deck(url) {
  const img = document.createElement('img')
  img.src = url
  img.style.width = '50%'
  img.style.height = '50%'
  img.style.display = 'block'
  img.style['margin-bottom'] = '10%'

  return img;
}

function make_blank() {
  const div = make_deck('https://media.istockphoto.com/id/485651937/photo/deck-of-uno-game-cards.jpg?s=612x612&w=0&k=20&c=UPAkLRxdHVyVyXJOW55iA-_Fg21BSIaZRVci-SOBx9c=' )
  div.style.opacity = '80%'
  return div
}
// Create four div elements
var box1 = document.createElement("div");
var box2 = document.createElement("div");
var box3 = document.createElement("div");
var box4 = document.createElement("div");

// Set the styles for the boxes
var boxStyle = "width: 100px; height: 100px; background-color: gray; margin: 10px; float: left;";
box1.setAttribute("style", boxStyle);
box2.setAttribute("style", boxStyle);
box3.setAttribute("style", boxStyle);
box4.setAttribute("style", boxStyle);

// Add the boxes to the new window
popup.document.body.appendChild(box1);
popup.document.body.appendChild(box2);
popup.document.body.appendChild(make_blank())
popup.document.body.appendChild(box3);
popup.document.body.appendChild(box4);
