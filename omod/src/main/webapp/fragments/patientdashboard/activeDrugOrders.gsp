<%
    def careSettings = activeDrugOrders.collect{it.careSetting}.unique()
%>

<style type="text/css">
    .info-body.active-drug-orders h4 {
        font-size: 1em;
    }
    .info-body.active-drug-orders h4:first-child {
        margin-top: 0px;
    }
</style>

<div class="info-section">

    <div class="info-header">
        <i class="icon-medicine"></i>
        <h3>${ ui.message("orderentryui.patientdashboard.activeDrugOrders").toUpperCase() }</h3>
        <% if (context.hasPrivilege("App: orderentryui.drugOrders")) { %>
            <a href="${ ui.pageLink("orderentryui", "drugOrders", [patient: patient.id, returnUrl: ui.thisUrl()]) }">
                <i class="icon-pencil edit-action right" title="${ ui.message("coreapps.edit") }"></i>
            </a>
        <% } %>
    </div>

    <div class="info-body active-drug-orders">
        <% if (!activeDrugOrders) { %>
            ${ ui.message("emr.none") }
        <% } else { %>

            <% careSettings.each { careSetting -> %>
                <h4>${ ui.format(careSetting) }</h4>
                <ul>
                    <% activeDrugOrders.findAll{ it.careSetting == careSetting }.each { %>
                    <li>
                        <label>${ ui.format(it.drug ?: it.concept) }</label>
                        <small>${ it.dosingInstructionsInstance.getDosingInstructionsAsString(sessionContext.locale) }</small>
                    </li>
                    <% } %>
                </ul>
            <% } %>
        <% } %>
    </div>

</div>