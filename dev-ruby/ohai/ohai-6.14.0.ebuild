# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ohai/ohai-6.14.0.ebuild,v 1.1 2012/08/11 09:14:47 hollow Exp $

EAPI=4
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.rdoc"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="Ohai profiles your system and emits JSON"
HOMEPAGE="http://wiki.opscode.com/display/chef/Ohai"
SRC_URI="https://github.com/opscode/${PN}/tarball/${PV} -> ${P}.tgz"
RUBY_S="opscode-${PN}-*"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RUBY_PATCHES=( "${FILESDIR}/ohai-6.14.0-multiple-ruby.patch" )

ruby_add_bdepend "test? ( dev-ruby/rspec:2 )"

ruby_add_rdepend "
	dev-ruby/ipaddress
	dev-ruby/mixlib-cli
	dev-ruby/mixlib-config
	dev-ruby/mixlib-log
	dev-ruby/systemu
	dev-ruby/yajl-ruby"

all_ruby_prepare() {
	rm Gemfile || die
}

all_ruby_install() {
	all_fakegem_install

	doman docs/man/man1/ohai.1
}
