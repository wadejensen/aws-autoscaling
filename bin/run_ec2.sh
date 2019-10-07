#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

main() {
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - && \
        apt-get install -y nodejs

    cat <<EOF > ~/server.sh
const http = require('http');
const port = 3000;
const MAX = 1000000000;
const server = http.createServer((req, res) => {
 let start = Date.now();
 for (let i=0; i<=MAX; i++) {
   let dummy = Math.log(i+1);
 }

 let timing = Date.now() - start;
 res.statusCode = 200;
 res.setHeader('Content-Type', 'text/plain');
 res.end('Hello World\n' + timing + "(ms)\n");
});
server.listen(port, () => {
 console.log(`Server listening on ${port}/`);
});
EOF
    chmod +x ~/server.sh
    node ~/server.sh
}

main "$@"
