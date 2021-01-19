<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.page>
    <div>Add new user</div>
    <@l.login "/registration" "Register"/>
    ${message!}
</@c.page>