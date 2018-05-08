# Set a role for varnish
set-varnish-role:
  grains.list_present:
    - name: roles
    - value: varnish

{% set varnish_version = salt['pillar.get']('varnish:version', '30') %}
varnish:
  pkg:
    - installed
    - enablerepo: varnishcache_varnish{{varnish_version}}
  service:
    - enable: True
    - running
    - watch:
      - file: /etc/varnish

# Version 4 uses new syntax, so we switch default templates on that.
{% if '4' in varnish_version|string  %}
{% set template_dir = 'salt://varnish/files-v4' %}
{% else %}
{% set template_dir = 'salt://varnish/files' %}
{% endif %}

/etc/varnish:
  file.recurse:
    # Custom VCL always overrides default templates
    - source: {{ salt['pillar.get']('varnish:vcl', template_dir ) }}
    - user: root

/etc/sysconfig/varnish:
  file.managed:
    - source: salt://varnish/files/sysconfig-varnish
    - template: jinja
    - watch_in:
      - service: varnish
    - context:
        varnish_version: '{{ varnish_version }}'
        port: {{ salt['pillar.get']('varnish:port', '80') }}
        memory: {{ salt['pillar.get']('varnish:memory', '500M') }}

/etc/varnish/secret:
  file.managed:
    - mode: 644
    - replace: False

/var/log/varnish:
  file.directory:
    - mode: 755
    - user: root
    - group: vagrant
