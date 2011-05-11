# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-augeas/ruby-augeas-0.4.1.ebuild,v 1.1 2011/05/11 15:11:11 matsuu Exp $

EAPI=3
# jruby -> native extentions
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_DOCDIR="doc/site/api"
RUBY_FAKEGEM_EXTRADOC="NEWS README.rdoc"

inherit multilib ruby-fakegem

DESCRIPTION="Ruby bindings for Augeas"
HOMEPAGE="http://augeas.net/"
SRC_URI="http://augeas.net/download/ruby/${P}.gem"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=app-admin/augeas-0.5.1"
RDEPEND="${DEPEND}"

each_ruby_configure() {
	${RUBY} -Cext/augeas extconf.rb || die
}

each_ruby_compile() {
	emake -Cext/augeas || die
}

each_ruby_install() {
	mv ext/augeas/_augeas$(get_modname) lib/ || die

	each_fakegem_install
}
