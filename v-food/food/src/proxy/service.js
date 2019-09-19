import {request} from "../services/request";

export default {
	tableware(params) {
		return request({
			method: "post",
			url: "/api/services.php?action=tableware",
			params
		})
	},
	invoice(params) {
		return request({
			method: "post",
			url: "/api/services.php?action=invoice",
			params
		})
	}
}