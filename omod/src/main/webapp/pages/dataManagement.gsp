<%
    ui.decorateWith("kenyaemr", "standardPage", [ layout: "sidebar" ])

    def menuItems = [
            [label: "Back", iconProvider: "kenyaui", icon: "buttons/back.png", label: "Back to NimeCONFIRM home", href: ui.pageLink("vdot", "vdotHome")]
    ]

%>
<style>
.mainBox {
    float: left;
}

.boxStyle {
    color: black;
    font-size: 1.5em;
    line-height: 1.5;
    border: 2px darkslategray solid;
    border-radius: 10px;
    padding: 10px 5px 5px 10px;
    margin: 5px 2px;
    width: 48%;
}
</style>

<div class="ke-page-sidebar">

    <div class="ke-panel-frame">
        ${ui.includeFragment("kenyaui", "widget/panelMenu", [heading: "Navigation", items: menuItems])}
    </div>
</div>

<div class="ke-page-content">
    <div class="mainBox boxStyle">
        ${ ui.includeFragment("vdot", "vdotEnrollmentStats") }

        <br/>
        <br/>
        <% if (pendingEnrollments > 0) { %>
        <button id="postMessagetoNimeConfirm">Push Enrollment(s) to nimeConfirm</button>
        <span id="msgBox"></span>
        <% } else { %>
        <span >No new enrollment(s) to push to nimeConfirm</span>


            <% } %>

    </div>
    <div class="mainBox boxStyle">
        Something here for pulling data



        <br/>
        <br/>
        <br/>
        <button style="border: solid" id="pullMessagesFromVdot">Pull data</button>
    </div>
</div>

<script type="text/javascript">
    jq = jQuery;
    jQuery(function() {

        jq('#pullMessagesFromVdot').click(function() {
            jq.getJSON('${ ui.actionLink("vdot", "vdotPatientData", "getMessagesFromVdot") }',
                {

                })
                .success(function(data) {
                    jq('#msgBox').html("Vdot messages processed successfully");
                })
                .error(function(xhr, status, err) {
                    jq('#msgBox').html("There was an error processing Vdot messages");
                })
        });

    });

    jq(function() {
        jq('#postMessagetoNimeConfirm').click(function() {
            jq.getJSON('${ ui.actionLink("vdot", "vdotPatientObservations", "postEnrollmentMessage") }')
                .success(function(data) {
                    jq('#msgBox').html("Successfully posted to nimeConfirm");
                })
                .error(function(xhr, status, err) {
                    jq('#msgBox').html("Could not post to nimeConfirm. Kindly contact an admin user for help");
                })
        });
    });
</script>