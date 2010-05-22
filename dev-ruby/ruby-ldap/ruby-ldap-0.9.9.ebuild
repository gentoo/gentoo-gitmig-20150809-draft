# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-ldap/ruby-ldap-0.9.9.ebuild,v 1.8 2010/05/22 15:49:25 flameeyes Exp $

inherit ruby

DESCRIPTION="A Ruby interface to some LDAP libraries"
HOMEPAGE="http://code.google.com/p/ruby-activeldap/"
SRC_URI="http://ruby-activeldap.googlecode.com/files/${P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86"
IUSE="ssl"
USE_RUBY="ruby18"
DEPEND=">=net-nds/openldap-2
	ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

# Current test set is interactive due to certificate generation and requires
# running LDAP daemon
RESTRICT="test"

src_compile() {
	ruby extconf.rb --with-openldap2 || die "extconf.rb failed"
	emake || die
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die
	dodoc ChangeLog FAQ README TODO
}
