varnish_repo:
  cmd.run:
    - name: curl -Ss 'https://packagecloud.io/install/repositories/varnishcache/varnish30/config_file.repo?os=centos&dist=6&source=script' > /etc/yum.repos.d/varnish.repo
    - creates: /etc/yum.repos.d/varnish.repo

disable_varnish_repo_default:
  cmd.run:
    - name: yum-config-manager --disable varnishcache_varnish30 varnishcache_varnish30-source
    - onchanges:
      - cmd: varnish_repo
