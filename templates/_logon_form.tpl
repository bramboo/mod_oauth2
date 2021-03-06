{# If user is already logged in, immediately redirect to authorization code URL #}
{% if m.acl.user %}
{% wire type="load" 
    postback={redirect_authorization_code_url client_id=q.client_id redirect_uri=q.redirect_uri} 
    delegate="mod_oauth2" 
%}
{% endif %}
<iframe src="/lib/images/spinner.gif" id="logonTarget" name="logonTarget" style="display:none"></iframe>
<form id="logon_form" method="post" action="postback" class="z_logon_form" target="logonTarget">
    {% if not hide_title %}
        {% if m.rsc.page_logon.title %}
            <h1 class="logon_header">{{ m.rsc.page_logon.title }}</h1>
        {% else %}
            <h1 class="logon_header">{_ Log on to _} <span>{{ m.config.site.title.value|default:"Zotonic" }}</span></h1>
        {% endif %}
    {% endif %}
    
    <input type="hidden" name="page" value="{{ page|escape }}" />
    <input type="hidden" name="handler" value="username" />
    <input type="hidden" name="redirect_uri" value="{{ q.redirect_uri }}" />
    <input type="hidden" name="client_id" value="{{ q.client_id }}" />
    
    <div class="form-group">
        <label for="username" class="control-label">{_ Username _}</label>
        <div>
	    <input class="form-control" type="text" id="username" name="username" value="" autofocus="autofocus" autocapitalize="off" autocomplete="on" />
            {% validate id="username" type={presence} %}
        </div>
    </div>

    <div class="form-group">
        <label for="password" class="control-label">{_ Password _}</label>
        <div>
	    <input class="form-control" type="password" id="password" name="password" value="" autocomplete="on" />
        </div>
    </div>

    <div class="form-group">
        <div>
	        <button class="btn btn-primary btn-lg pull-right" type="submit">{_ Log on _}</button>
	        <div class="checkbox"><label title="{_ Stay logged on unless I log off. _}">
            	<input type="checkbox" name="rememberme" value="1" />
                {_ Remember me _}
            </label></div>
        </div>
    </div>

    <div>
        <a href="{% url logon_reminder %}">{_ I forgot my password _}</a>
    </div>
</form>
