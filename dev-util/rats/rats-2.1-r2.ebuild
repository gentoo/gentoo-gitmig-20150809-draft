# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/rats/rats-2.1-r2.ebuild,v 1.5 2007/08/27 20:24:57 robbat2 Exp $

inherit eutils

DESCRIPTION="RATS - Rough Auditing Tool for Security"
HOMEPAGE="http://www.fortifysoftware.com/security-resources/rats.jsp"
SRC_URI="http://www.fortifysoftware.com/servlet/downloads/public/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""
DEPEND="dev-libs/expat
		virtual/libc"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-add-getopt-trailing-null.patch
	epatch ${FILESDIR}/${P}-fix-null-pointers.patch
}

src_compile() {
	econf --datadir="/usr/share/${PN}/" || die
	emake || die
}

src_install () {
	einstall SHAREDIR="${D}/usr/share/${PN}" MANDIR="${D}/usr/share/man" || die
	dodoc README README.win32
}

pkg_postinst() {
	ewarn "Please be careful when using this program with it's force language"
	ewarn "option, '--language <LANG>' it may take huge amounts of memory when"
	ewarn "it tries to treat binary files as some other type."
}
