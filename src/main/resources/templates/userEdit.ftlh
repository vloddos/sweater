<#import "parts/common.ftlh" as c>

<@c.page>
    <div>User Editor</div>
    <form method="post" action="/user">
        <input type="text" value="${user.username}" name="username"/>
        <#list roles as role>
            <div>
                <label>
                    <input
                            type="checkbox"
                            name="${role}"
                            ${user.roles?seq_contains(role)?string("checked", "")}
                    />
                    ${role}
                </label>
            </div>
        </#list>
        <input type="hidden" value="${user.id}" name="userId"/>
        <input type="hidden" value="${_csrf.token}" name="_csrf"/>
        <button type="submit">Save</button>
    </form>
</@c.page>