# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ohai/ohai-0.6.2.ebuild,v 1.1 2011/04/23 06:28:23 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.rdoc"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="Ohai profiles your system and emits JSON"
HOMEPAGE="http://wiki.opscode.com/display/chef/Ohai"
SRC_URI="https://github.com/opscode/${PN}/tarball/${PV} -> ${P}.tgz"
S="${WORKDIR}/opscode-${PN}-*"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/rspec:2 )"

ruby_add_rdepend "
	dev-ruby/yajl-ruby
	dev-ruby/mixlib-cli
	dev-ruby/mixlib-config
	dev-ruby/mixlib-log
	dev-ruby/systemu"

all_ruby_install() {
	all_fakegem_install

	doman docs/man/man1/ohai.1
}
