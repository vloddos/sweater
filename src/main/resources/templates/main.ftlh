<#import "parts/common.ftlh" as c>

<@c.page>

<div class="form-row">
    <div class="form-group col-md-6">
        <form class="form-inline" method="get" action="/main">
            <input class="form-control" type="text" name="filter" value="${filter!}" placeholder="Search by tag"/>
            <button class="btn btn-primary ml-2" type="submit">Search</button>
        </form>
    </div>
</div>

<a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
    Post Message
</a>
<div class="collapse" id="collapseExample">
    <div class="form-group mt-3">
        <form method="post" enctype="multipart/form-data">
            <div class="form-group">
                <input class="form-control" type="text" name="text" placeholder="Type message"/>
            </div>

            <div class="form-group">
                <input class="form-control" type="text" name="tag" placeholder="Tag"/>
            </div>

            <div class="form-group">
                <div class="custom-file">
                    <input type="file" name="file" id="customFile"/>
                    <label class="custom-file-label" for="customFile">Choose File</label>
                </div>
            </div>

            <input type="hidden" name="_csrf" value="${_csrf.token}"/>

            <div class="form-group">
                <button class="btn btn-primary" type="submit">Post</button>
            </div>
        </form>
    </div>
</div>

<div class="card-columns">
    <#list messages as message>
        <div class="card my-3">
            <#if message.filename??>
                <img class="card-img-top" src="/img/${message.filename}"/>
            </#if>

            <div class="m-2">
                <span>${message.text}</span>
                <i>${message.tag}</i>
            </div>
            <div class="card-footer text-muted">${message.authorName}</div>
        </div>
    <#else>
        <div>No messages</div>
    </#list>
</div>

</@c.page>