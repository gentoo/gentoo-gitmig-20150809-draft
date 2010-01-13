# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/actionwebservice/actionwebservice-2.3.5.ebuild,v 1.1 2010/01/13 12:22:38 flameeyes Exp $

EAPI=2
USE_RUBY="ruby18"

MY_OWNER="panztel"

RUBY_FAKEGEM_NAME="${MY_OWNER}-${PN}"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README TODO"

RUBY_FAKEGEM_EXTRAINSTALL="generators"

inherit ruby-fakegem

DESCRIPTION="Simple Support for Web Services APIs for Rails"
HOMEPAGE="http://github.com/${MY_OWNER}/${PN}"

LICENSE="MIT"
SLOT="2.3"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "=dev-ruby/actionpack-2.3*
	=dev-ruby/activerecord-2.3*"

# it uses activerecord when running tests, but they don't work so
# ignore them for now.
#ruby_add_bdepend test 'dev-ruby/sqlite3-ruby'
RESTRICT=test

each_ruby_install() {
	each_fakegem_install
}

all_ruby_install() {
	all_fakegem_install

	pushd examples
	insinto /usr/share/doc/${PF}/examples
	doins -r *
	popd
}
