# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/chef-expander/chef-expander-0.10.2.ebuild,v 1.2 2011/08/06 14:23:51 graaff Exp $

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

RDEPEND=""

ruby_add_rdepend "~app-admin/chef-${PV}
	>=dev-ruby/amqp-0.6.7:0
	>=dev-ruby/bunny-0.6.0
	>=dev-ruby/em-http-request-0.2.11
	>=dev-ruby/eventmachine-0.12.10
	>=dev-ruby/fast_xs-0.7.3
	>=dev-ruby/highline-1.6.1
	>=dev-ruby/mixlib-log-1.2.0
	>=dev-ruby/uuidtools-2.1.1
	>=dev-ruby/yajl-ruby-0.7.7"

all_ruby_install() {
	all_fakegem_install

	doinitd "${FILESDIR}/initd/chef-expander"
	doconfd "${FILESDIR}/confd/chef-expander"

	keepdir /etc/chef /var/{lib,log,run}/chef
	fowners chef:chef /var/{lib,log,run}/chef
}
