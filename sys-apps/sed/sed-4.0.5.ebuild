# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sed/sed-4.0.5.ebuild,v 1.17 2004/08/19 21:57:54 vapier Exp $

DESCRIPTION="Super-useful stream editor"
HOMEPAGE="http://www.gnu.org/software/sed/sed.html"
SRC_URI="mirror://gnu/sed/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc alpha hppa mips"
IUSE="nls static build"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	econf `use_enable nls` || die
	if use static ; then
		emake || die
	else
		emake LDFLAGS=-static || die
	fi
}

src_install() {
	into /
	dobin sed/sed
	dodir /usr/bin
	dosym ../../bin/sed /usr/bin/sed
	if ! use build
	then
		into /usr
		doinfo doc/sed.info*
		doman doc/sed.1
		dodoc COPYING NEWS README* THANKS TODO AUTHORS BUGS ANNOUNCE ChangeLog
	else
		rm -rf ${D}/usr/share
	fi
}
