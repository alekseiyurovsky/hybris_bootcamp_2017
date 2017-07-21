$(document)
		.on(
				"click",
				".apply-to-cart-enabled",
				function(e) {

					e.preventDefault();
					var params = new Object();
					params["voucherCode"] = this.id;
					params["CSRFToken"] = ACC.config.CSRFToken;
					var couponToCartAction, buttonText, classtoAdd, classToRemove, errorMsg = "";

					if (isCouponApplied( this))

					{

						couponToCartAction = "apply";
						buttonText = "Remove from Cart";
						classtoAdd = "disabled";
						errorMsg = "Failed to Apply to cart";

					}

					else

					{

						couponToCartAction = "remove";
						buttonText = "Apply to Cart";
						classToRemove = "disabled";
						errorMsg = "Failed to Remove from cart";

					}

					handleCouponToCartAction(couponToCartAction, params,
							buttonText, classToRemove, classtoAdd, errorMsg);

				});

function isCouponApplied(couponCode) {
	return (!$(couponCode).hasClass("disabled"))
}

function handleCouponToCartAction(couponToCartAction, params, buttonText,
		classToRemove, classtoAdd, errorMsg) {
    
	var couponTagId= params["voucherCode"];
    params["voucherCode"] = "csa_coupon_"+params["voucherCode"];
	
    return $.ajax({
		url : ACC.config.encodedContextPath + "/cart/voucher/"
				+ couponToCartAction,
		timeout : params.timeout,
		type : "POST",
		data : params,
		success : function(data) {

			$("div [id='" + couponTagId + "hide']").toggle();
			$("div [id='" + couponTagId + "show']").toggle();

		},
		error : function(xht, textStatus, ex) {
			$("[id='" + params["voucherCode"] + "']").html(errorMsg);
		}

	});

}