// Create a new window
var popup = window.open("", "popup", "width=450,height=200");
const deck = Deck
const player1 = One
const unogame = Game 
const hand1 = player1.hand
const url1 = 'https://media.istockphoto.com/id/485651937/photo/deck-of-uno-game-cards.jpg?s=612x612&w=0&k=20&c=UPAkLRxdHVyVyXJOW55iA-_Fg21BSIaZRVci-SOBx9c=' 

function make_deck(url) {
  const img = document.createElement('img');
  img.src = url;
  img.style.width = '50%';
  img.style.height = '50%';
  img.style.display = 'block';
  img.style['margin-bottom'] = '10%';
  var deckStyle = "width: 100px; height: 100px; background-color: gray; margin: 50px; float: left;";
  img.setAttribute("style", deckStyle)

  return img;
}



function trial() { 
    // const img1 = document.createElement('img')
    // const img2 = document.createElement('img')
    // const img3 = document.createElement('img')
    // const img4 = document.createElement('img')
    image_container = document.createElement("div")
    const hand1 = One.hand
    const hand2 = Two.hand
    for (let i = 0; i < 4; i++) {
      const color = One.hand[i].color
      const num = One.hand[i].number //not used rn 
      var imageStyle = "width: 100px; height: 100px; background-color: gray; margin: 10px; float: left;";
      const img = document.createElement('img')
      img.setAttribute("style", imageStyle)
      if (i == 0){ 
        img.src = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-red1.png'
      } else if (i == 1) {
        img.src = 'https://i.pinimg.com/originals/80/8a/e0/808ae01a2c8c8634b967c9a9ea59b1cf.png'
      } else if (i == 2) { 
        img.src = 'https://media.baamboozle.com/uploads/images/182571/1613773171_86287.png'
      } else if (i == 3) {
        img.src = 'https://dbdzm869oupei.cloudfront.net/img/vinylrugs/preview/55306.png'
      }
    //   if (color == Red) { 
    //     img.src = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-red1.png'
    //   } else if (color == Blue) {
    //     img.src = 'https://i.pinimg.com/originals/80/8a/e0/808ae01a2c8c8634b967c9a9ea59b1cf.png'
    //   } else if (color == Green) { 
    //     img.src = 'https://media.baamboozle.com/uploads/images/182571/1613773171_86287.png'
    //   } else if (color == Yellow) {
    //     img.src = 'https://dbdzm869oupei.cloudfront.net/img/vinylrugs/preview/55306.png'
    //   }
      image_container.appendChild(img)
      //document.write(hand1)
      for (const ind in hand1.tuples()) {
        const cards = hand1.tuples()[ind]
        document.write(cards)
        // for (const ind2 in cards.tuples()) {
        //   document.write(typeof(cards.tuples()[0]))
        // }     
      }
     
    }
    return image_container
  }
function make_blank() {
  const div = make_deck('https://media.istockphoto.com/id/485651937/photo/deck-of-uno-game-cards.jpg?s=612x612&w=0&k=20&c=UPAkLRxdHVyVyXJOW55iA-_Fg21BSIaZRVci-SOBx9c=' )
  div.style.opacity = '80%'
  return div
}

function make_cards() {
    const div = trial()
    div.style.opacity = '70%'
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
// popup.document.body.appendChild(box1);
// popup.document.body.appendChild(box2);
popup.document.body.appendChild(make_cards())
popup.document.body.appendChild(make_blank())
// popup.document.body.appendChild(box3);
// popup.document.body.appendChild(box4);
popup.document.body.appendChild(make_cards())
