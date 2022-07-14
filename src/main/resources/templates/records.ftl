<#include "parts/security.ftl">
<#import "parts/common.ftl" as c>

<@c.page>
    <div class="form-row mb-2">
        <div class="form-group col-md-6">
            <form method="get" action="/record" class="form-inline">
                <input type="text" name="filter" class="form-control" value="${filter?ifExists}"
                       placeholder="Search by tag">
                <button type="submit" class="btn btn-primary ml-2">Поиск</button>
            </form>
        </div>
    </div>

    <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false"
       aria-controls="collapseExample">
        Добавить запись
    </a>
    <div class="collapse <#if record??>show</#if>" id="collapseExample">
        <div class="form-group mt-3">
            <form method="post" enctype="multipart/form-data">
                <div class="form-group mb-2">
                    <input type="text" class="form-control ${(textError??)?string('is-invalid','')}"
                           value="<#if record??>${record.text}</#if>" name="text" placeholder="Введите текст"/>
                    <#if textError??>
                        <div class="invalid-feedback">
                            ${textError}
                        </div>
                    </#if>
                </div>
                <div class="form-group mb-2">
                    <input type="text" class="form-control ${(textError??)?string('is-invalid','')}"
                           value="<#if record??>${record.number}</#if>" name="number"
                           placeholder="Номер">
                    <#if numberError??>
                        <div class="invalid-feedback">
                            ${numberError}
                        </div>
                    </#if>
                </div>
                <div class="form-group mb-2">
                    <input type="text" value="<#if record??>${record.tag}</#if>"
                           class="form-control" name="tag"
                           placeholder="Тэг">
                    <#if tagError??>
                        <div class="invalid-feedback">
                            ${tagError}
                        </div>
                    </#if>
                </div>
                <div class="form-group mb-3">
                    <input name="file" class="form-control form-control-sm" id="formFileSm" type="file">
                </div>
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">Добавить</button>
                </div>
            </form>
        </div>
    </div>

    <div class="mt-3">
    </div>

    <div class="container px-4 px-lg-5">
        <div class="row row-flex gx-1 gy-2">
            <#list records as record>
                <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">

                    <div class="card">
                        <div class="text-center p-3">
                            <#if record.filename??>
                                <img src="/img/${record.filename}" class="card-img-top" style="width: 5rem;">
                            </#if>
                        </div>
                        <div class="card-body text-center">
                            <span><strong>${record.text}</strong></span>
                            <div class="m-2">
                                <strong>${record.number}</strong>
                            </div>
                            <div class="m-2">
                                <i>${record.tag}</i>
                            </div>
                            <div class="card-footer text-muted">
                                <div class="card-footer text-muted">
                                    ${record.authorName}
                                </div>
                            </div>
                        </div>

                        <div class="container px-4">
                            <div class="row-flex">
                                <div class="px-lg-1">
                                    <form action="${record.id}/remove" method="post">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                                        <button class="btn btn-dark mt-2 mb-2" type="submit">Удалить</button>
                                    </form>
                                </div>
                                <div class="px-lg-2">
                                    <form action="${record.id}/editRecord" method="get">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                                        <button class="btn btn-dark mt-2 mb-2" type="submit">Редактировать
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            <#else>
                Нет записей
            </#list>
        </div>
    </div>
</@c.page>


