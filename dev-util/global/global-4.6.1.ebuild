# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/global/global-4.6.1.ebuild,v 1.4 2004/06/25 02:33:43 agriffis Exp $

IUSE="ssl postgres"

DESCRIPTION="Global can find the locations of specified object in C, C++, Yacc, Java and assembler source files."
HOMEPAGE="http://www.gnu.org/software/global/"
LICENSE="GPL-2"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

KEYWORDS="~x86"
SLOT="0"

DEPEND=">=sys-libs/glibc-2.2
	postgres? ( >=dev-db/postgresql-7.1 )
	ssl? ( >=dev-libs/openssl-0.9.6-r1 )"

src_compile() {
	local myconf

	if use postgres; then
		myconf="--with-postgres=/usr"
		if use ssl; then
			# Patch configure to add -lssl when using postgresql and ssl
			sed -i 's/-lcrypt/-lcrypt -lssl/' configure || die 'sed failed'
		fi
	fi

	econf || die "econf failed"
	emake || die
}

src_install() {
	einstall || die
	insinto /etc
	doins gtags.conf
	dodoc AUTHORS COPYING INSTALL LICENSE NEWS README THANKS
	insinto /usr/share/${PN}
	doins gtags.el gtags.pl globash.rc
}
