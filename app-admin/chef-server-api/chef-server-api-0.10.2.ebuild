# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/chef-server-api/chef-server-api-0.10.2.ebuild,v 1.1 2011/07/25 09:16:54 hollow Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="Configuration management tool"
HOMEPAGE="http://wiki.opscode.com/display/chef"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-db/couchdb-0.10.0
	>=net-misc/rabbitmq-server-1.7.0"

ruby_add_rdepend "~app-admin/chef-${PV}
	>=dev-ruby/dep_selector-0.0.3
	>=dev-ruby/json-1.4.4
	<=dev-ruby/json-1.4.6
	>=dev-ruby/mixlib-authentication-1.1.3
	>=dev-ruby/merb-assets-1.1.0
	>=dev-ruby/merb-core-1.1.0
	>=dev-ruby/merb-helpers-1.1.0
	>=dev-ruby/merb-param-protection-1.1.0
	>=dev-ruby/uuidtools-2.1.1
	www-servers/thin"

each_ruby_install() {
	each_fakegem_install
	ruby_fakegem_doins -r app
	ruby_fakegem_doins -r config
	ruby_fakegem_doins -r public
}

all_ruby_install() {
	all_fakegem_install

	newinitd "${FILESDIR}/initd/chef-server-api-r1" ${PN}
	doconfd "${FILESDIR}/confd/chef-server-api"

	keepdir /etc/chef /var/lib/chef /var/log/chef /var/run/chef \
		/etc/chef/certificates

	insinto /etc/chef
	doins "${FILESDIR}/server.rb"

	fperms 0700 /etc/chef/certificates
	fowners chef:chef /etc/chef/{,server.rb,certificates}
	fowners chef:chef /var/{lib,log,run}/chef
}

pkg_postinst() {
	elog
	elog "You should edit /etc/chef/server.rb before starting the service with"
	elog "/etc/init.d/chef-server-api start"
	elog
}
