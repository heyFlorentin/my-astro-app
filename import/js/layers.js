let n;
var t = (o) => {
    if (!n) {
        const r = o.forwardRef(({color: i = "currentColor", size: e = 24, ...s}, l) => {
            return o.createElement("svg", {ref: l, xmlns: "http://www.w3.org/2000/svg", width: e, height: e, viewBox: "0 0 24 24", fill: "none", stroke: i, strokeWidth: "2", strokeLinecap: "round", strokeLinejoin: "round", ...s}, o.createElement("polygon", {points: "12 2 2 7 12 12 22 7 12 2"}), o.createElement("polyline", {points: "2 17 12 22 22 17"}), o.createElement("polyline", {points: "2 12 12 17 22 12"}));
        });
        r.displayName = "Layers",n = r;
    }
    return n;
};
const __FramerMetadata__ = {exports: {default: {type: "reactComponent", slots: [], annotations: {framerContractVersion: "1"}}, __FramerMetadata__: {type: "variable"}}};
export { __FramerMetadata__, t as default };