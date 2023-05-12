d3 = require('d3')
d3.selectAll("svg > *").remove();

// Create a new window
var popup = window.open("", "popup", "width=450,height=200");

/** URLs for each card */ 
const red0 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-red0.png';
const blue0 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-blue0.png';
const yellow0 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-yellow0.png';
const green0 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-green0.png';
const red1 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-red1.png';
const blue1 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-blue1.png';
const yellow1 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-yellow1.png';
const green1 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-green1.png';
const red2 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-red2.png';
const blue2 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-blue2.png'; 
const yellow2 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-yellow2.png';
const green2 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-green2.png';
const red3 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-red3.png';
const blue3 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-blue3.png'; 
const yellow3 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-yellow3.png';
const green3 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-green3.png'; 
const red4 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-red4.png'; 
const blue4 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-blue4.png'; 
const yellow4 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-yellow4.png'; 
const green4 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-green4.png'; 
const red5 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-red5.png';
const blue5 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-blue5.png'; 
const yellow5 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-yellow5.png'; 
const green5 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-green5.png'; 
const red6 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-red6.png'; 
const blue6 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-blue6.png';
const yellow6 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-yellow6.png';
const green6 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-green6.png'; 
const red7 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-red7.png'; 
const blue7 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-blue7.png'; 
const yellow7 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-yellow7.png'; 
const green7 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-green7.png'
const red8 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-red8.png'
const blue8 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-blue8.png';
const yellow8 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-yellow8.png';
const green8 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-green8.png'
const red9 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-red9.png';
const yellow9 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-yellow9.png';
const green9 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-green9.png';
const blue9 = 'https://unocardinfo.victorhomedia.com/graphics/uno_card-blue9.png';

/** Every card of each color */
const red_cards= [red0, red1, red2, red3, red4, red5, red6, red7, red8, red9];
const blue_cards = [blue0, blue1, blue2, blue3, blue4, blue5, blue6, blue7, blue8, blue9];
const green_cards = [green0, green1, green2, green3, green4, green5, green6, green7, green8, green9];
const yellow_cards = [yellow0, yellow1, yellow2, yellow3, yellow4, yellow5, yellow6, yellow7, yellow8, yellow9];

/**
 * theArray: All NumberCards 
 * myArr: NumberCards in number format (eg. NumberCard21 -> 21) 
 */
const theArray = instance.signature('NumberCard').atoms()
const myArr = []; 
for (const card in theArray) { 
    myArr.push(card)
}

/**
 * commonElements: Common numbers in myArr and One.hand/Two.hand
 * colors: colors of the NumberCard of each common card for hand
 * ints: numbers of the NumberCard of each common card for hand
 */
let commonElements1 = myArr.filter(element => One.hand.toString().match(/\d+/g).includes(element));
let colors1 = [];
let ints1 = [];

for (i = 0; i < commonElements1.length; i++) {
  colors1.push(theArray[commonElements1[i]].color.toString())
  ints1.push(theArray[commonElements1[i]].number.toString())
}

let commonElements2 = myArr.filter(element => Two.hand.toString().match(/\d+/g).includes(element));
let colors2 = [];
let ints2 = [];

for (i = 0; i < commonElements2.length; i++) {
  colors2.push(theArray[commonElements2[i]].color.toString())
  ints2.push(theArray[ commonElements2[i]].number.toString())
}

//Debugging textbox
// const stage = new Stage()
// stage.add(new TextBox({
//   text: commonElements2,
//   coords: {x:100, y:100},
//   color: 'black',
//   fontSize: 16}))
// stage.render(svg, document)

/**
 * 
 * @param {*} url 
 * @returns Deck according to specifications 
 */
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

/**
 * 
 * @param {*} hand - Either 1 or 2 for player 1 or 2
 * @returns image container with images of each card in that player's hand
 */
function get_cards(hand) { 
    image_container = document.createElement("div") //contains images to be returned
    if (hand == 1) {
      for (i = 0; i < colors1.length; i++) {
        var imageStyle = "width: 100px; height: 100px; background-color: gray; margin: 10px; float: left;";
        const img = document.createElement('img')
        img.setAttribute("style", imageStyle)
        if (colors1[i] == "Red0") {
          img.src = red_cards[ints1[i]]
        }
        if (colors1[i] == "Blue0") {
          img.src = blue_cards[ints1[i]]
        }
        if (colors1[i] == "Yellow0") {
          img.src = yellow_cards[ints1[i]]
        }
        if (colors1[i] == "Green0") {
          img.src = green_cards[ints1[i]]
        }
        image_container.appendChild(img)
      }
    }
    if (hand == 2) {
      for (i = 0; i < colors2.length; i++) {
        var imageStyle = "width: 100px; height: 100px; background-color: gray; margin: 10px; float: left;";
        const img = document.createElement('img')
        img.setAttribute("style", imageStyle)
        if (colors2[i] == "Red0") {
          img.src = red_cards[ints2[i]]
        }
        if (colors2[i] == "Blue0") {
          img.src = blue_cards[ints2[i]]
        }
        if (colors2[i] == "Yellow0") {
          img.src = yellow_cards[ints2[i]]
        }
        if (colors2[i] == "Green0") {
          img.src = green_cards[ints2[i]]
        }
        image_container.appendChild(img)
      }
    }
    return image_container
  }

function deck() {
  var url = 'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/fed3bb24-454f-4bdf-a721-6aa8f23e7cef/d9gnihf-ec16caeb-ec9c-4870-9480-57c7711d844f.png/v1/fill/w_486,h_759/uno_card_back_by_wackosamurai_d9gnihf-fullview.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NzU5IiwicGF0aCI6IlwvZlwvZmVkM2JiMjQtNDU0Zi00YmRmLWE3MjEtNmFhOGYyM2U3Y2VmXC9kOWduaWhmLWVjMTZjYWViLWVjOWMtNDg3MC05NDgwLTU3Yzc3MTFkODQ0Zi5wbmciLCJ3aWR0aCI6Ijw9NDg2In1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLm9wZXJhdGlvbnMiXX0.TMtpsV_KVjgkIMqwza3ooob2Xq5bihDuT0JVsOldrpA'
  if (Game.lastPlayed.toString() != null) {
    const colorlp = Game.lastPlayed.color.toString(); 
    const numlp = Game.lastPlayed.number.toString(); 
    if (colorlp == "Red0") {
      url = red_cards[numlp] 
    }
    else if (colorlp == "Blue0") {
      url = blue_cards[numlp]
    }
    if (colorlp == "Yellow0") {
      url = yellow_cards[numlp]
    }
    if (colorlp == "Green0") {
      url = green_cards[numlp]
    }
  }
  const div = make_deck(url)
  div.style.opacity = '80%'
  return div
}

function playerHand(handnum) {
    const div = get_cards(handnum)
    div.style.opacity = '70%'
    return div 
}

popup.document.body.appendChild(playerHand(1))
popup.document.body.appendChild(deck())
popup.document.body.appendChild(playerHand(2))

/*
STATE_HEIGHT = 100
states = 
     d3.select(svg)
     // <g> is element for group in SVG
     // D3 is based on these "sandwich" calls:
     //   there's no <g> element yet, but there will be once the data is
     //   processed. Bind the data to those <g> elements...
     .selectAll('g') 
     // Here's the data to bind. The map just makes sure we have the array index
     // Can use either old or new style anonymous functions
     .data(instances.map(function(d,i) {
        return {item: d, index: i}    
     }))
     // Now, for every entry in that array...
     .enter()   
     // Add a <g> (finally)
     .append('g')
     // Give it a class, for ease of debugging and possible use in future visualizations
     .classed('state', true)
     // Give it an 'id' attribute that's the state index (used later for labeling)
     .attr('id', d => d.index)        

// Now, for each state <g>, add a <rect> to the group
states
    .append('rect')
    .attr('x', 10)
     .attr('y', function(d) {
         return 20 + STATE_HEIGHT * d.index
     })
    .attr('width', 300)
    .attr('height', STATE_HEIGHT)
    .attr('stroke-width', 2)
    .attr('stroke', 'black')
    .attr('fill', 'transparent');

// Debugging code, used to confirm that the rects were being 
// re-rendered every run, early in writing this script
// Leaving this in for illustrative purposes
// states
//     .append("text")
//     .style("fill", "black")
//      .attr('y', function(d) {
//          return 40 + 220 * d.index
//      })
//      .attr('x', 50)
//      // If we don't wrap in a function, will be same value for ALL states
//      //.text(Math.random());
//      // Instead, provide a different random number for each state label
//      .text(function(d) {
//          return Math.random()});

// For each state <g>, add a state index label
// Recall that 'd' here is a variable bound to a specific data element,
//   in this case, a state
states
    .append("text")
    .style("fill", "black")
     .attr('y', function(d) {
         return 40 + STATE_HEIGHT * d.index
     })
     .attr('x', 50)
     .text(d => "State "+d.index);


hands = 
     states 
     .selectAll('rectangle')
     .data( function(d) {
       inst = d.item 
       hand1 = One.hand.toString()
       hand2 = Two.hand.toString()
       hands = hand1.concat(hand2)
       cards = inst.signature('NumberCard').tuples()
       return cards.map( function (ld) {
         return {item: ld,
                 state: d.index
                 
                }
       })
     }
     )
// Now, within each state <g>
// lightGroups = 
//     states
//     // ...as before, we want to bind the sub-data (light values WITHIN a state)
//     .selectAll('circle')
//     .data( function(d) {        
//         inst = d.item
//         lit = inst.signature('Lit').tuples()
//         unlit = inst.signature('Unlit').tuples()
//         lights = lit.concat(unlit)
//         return lights.map( function (ld) {
//             return {item:  ld, 
//                     index: lightToIdx[ld.toString().slice(-1)],
//                     on: lit.includes(ld), 
//                     state: d.index}
//         })
    //})
    // for each of them
    .enter()
    // Add a new sub-group
    .append('g')
    .classed('light', true)
// Each light contains a circle...
hands
    .append('circle')    
    // useful for debugging in inspector
    .attr('index', d => d.index)
    .attr('state', d => d.state)
    .attr('item',  d => d.item)
    .attr('r', 20)
    .attr('cx', function(d) {
        return 50 + d.index * 50
    })
    .attr('cy', function(d) {
        return 70 + d.state * STATE_HEIGHT
    })
    .attr('stroke', 'gray')
    .attr('fill', function(ld){
        if(ld.on == true) return 'yellow';
        else return 'gray';
    });

// ...and an index label
hands
     .append('text')
     .attr('y', d => 75 + d.state * STATE_HEIGHT)
     .attr('x', d => 47 + d.index * 50)
     .text(d=>d.index);

     */ 