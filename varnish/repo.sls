{% set varnish_version = salt['pillar.get']('varnish:version', '30') %}

varnish_repo:
  cmd.run:
    - name: curl -Ss 'https://packagecloud.io/install/repositories/varnishcache/varnish{{varnish_version}}/config_file.repo?os=centos&dist=6&source=script' > /etc/yum.repos.d/varnish.repo
    - creates: /etc/yum.repos.d/varnish.repo

disable_varnish_repo_default:
  cmd.run:
    - name: |
        yum-config-manager --disable varnishcache_varnish{{varnish_version}} varnishcache_varnish{{varnish_version}}-source
        yum -q makecache -y --disablerepo='*' --enablerepo='varnishcache_varnish{{varnish_version}}'
    - onchanges:
      - cmd: varnish_repo
