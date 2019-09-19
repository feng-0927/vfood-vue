import {request} from "./request";

const io = "http://cdn.bootcss.com/socket.io/1.3.7/socket.io.js";

export default request({
	method: "get",
	url: io
});