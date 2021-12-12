"use strict";
export const __esModule = true;
const _hello = void 0;
export { _hello as hello };
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
var world = "world";
export function hello(_world) {
  if (_world === void 0) {
    _world = world;
  }
  return "Hello ".concat(_world, "! ");
}
const _hello = hello;
export { _hello as hello };
