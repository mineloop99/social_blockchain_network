// import { Mainnet, DAppProvider, Config } from '@usedapp/core'
// import ReactDOM from 'react-dom'
// import React from 'react';
// import App from './App';

// const config: Config = {
//   readOnlyChainId: Mainnet.chainId,
//   readOnlyUrls: {
//     [Mainnet.chainId]: 'https://mainnet.infura.io/v3/3250acf68d6246798366214e39686470',
//   },
// }

// ReactDOM.render(
//   <React.StrictMode>
//     <DAppProvider config={config} children>
//       <App />
//     </DAppProvider>
//   </React.StrictMode>,
//   document.getElementById('root')
// )

const world = 5;
const world2 = 5;

function add(_world:number, _world2:number) {
    return _world + _world2;
}

const result = add(world, world2);

console.log(result);