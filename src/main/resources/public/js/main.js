const style = {};

const current_geometry = () => {
  if (!style.width || !style.height) {
    const text = $('.xterm-helpers style').text();
    let arr = text.split('xterm-normal-char{width:');
    style.width = parseFloat(arr[1]);
    arr = text.split('div{height:');
    style.height = parseFloat(arr[1]);
  }
  const cols = parseInt(window.innerWidth / style.width, 10) - 1;
  const rows = parseInt(window.innerHeight / style.height, 10);
  return { cols: cols, rows: rows };
};

const resize_term = (term, ws) => {
  const geometry = current_geometry(),
    cols = geometry.cols,
    rows = geometry.rows;
  if (cols !== term.geometry[0] || rows !== term.geometry[1]) {
    console.log(`resizing term to ${JSON.stringify({ cols, rows })}`);
    term.resize(cols, rows);
    ws.send(
      action('TERMINAL_RESIZE', {
        columns: cols,
        rows,
      })
    );
  }
};

$(window).resize(function() {
  resize_term(term, ws);
});

let ws = new WebSocket('ws://' + location.host + '/terminal');
let term = new Terminal({
  cursorBlink: true,
});

term.on('data', command => {
  console.log(command);
  ws.send(
    action('TERMINAL_COMMAND', {
      command,
    })
  );
});

ws.onopen = () => {
  ws.send(action('TERMINAL_INIT'));
  ws.send(action('TERMINAL_READY'));
  term.open(document.getElementById('#terminal'), true);
  term.toggleFullscreen(true);
};

ws.onerror = e => {
  console.log(e);
};

ws.onclose = e => {
  console.log(e);
  term.destroy();
};

ws.onmessage = e => {
  if (!term.resized) {
    resize_term(term, ws);
    term.resized = true;
  }
  let data = JSON.parse(e.data);
  switch (data.type) {
    case 'TERMINAL_PRINT':
      term.write(data.text);
  }
};

function action(type, data) {
  let action = Object.assign(
    {
      type,
    },
    data
  );

  return JSON.stringify(action);
}
