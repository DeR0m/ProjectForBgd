<#include "parts/security.ftl">
<#import "parts/common.ftl" as c>

<@c.page>
    <h5>${record.text}</h5>

    <div class="container px-4 px-lg-5">
        <div class="info">
            <div class="form-group mt-3">
                <form action="/editRecord" method="post" enctype="multipart/form-data">
                    <div class="form-group mb-3">
                        <input type="text"
                               class="form-control form-control-sm ${(textError??)?string('is-invalid','')}"
                               value="<#if record??>${record.text}</#if>"
                               placeholder="Текст" aria-label="text"
                               name="text"
                               aria-describedby="basic-addon1">
                        <#if textError??>
                            <div class="invalid-feedback">
                                ${textError}
                            </div>
                        </#if>
                    </div>
                    <div class="form-group mb-3">
                        <input type="text" class="form-control ${(textError??)?string('is-invalid','')}"
                               value="<#if record??>${record.number}</#if>" name="number"
                               placeholder="Номер">
                        <#if numberError??>
                            <div class="invalid-feedback">
                                ${numberError}
                            </div>
                        </#if>
                    </div>
                    <div class="form-group mb-3">
                        <input type="text" value="<#if record??>${record.tag}</#if>" class="form-control" name="tag"
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

                    <input type="hidden" value="<#if record??>${record.id}</#if>" name="recordId">
                    <input type="hidden" name="_csrf" value="${_csrf.token}">

                    <div class="form-group">
                        <button type="submit" class="btn btn-outline-secondary">Сохранить</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</@c.page>