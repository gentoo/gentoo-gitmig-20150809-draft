# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/commonc++/commonc++-1.9.7-r3.ebuild,v 1.16 2004/11/02 22:02:15 gustavoz Exp $

inherit eutils

DESCRIPTION="GNU Common C++ is a C++ framework offering portable support for threading, sockets, file access, daemons, persistence, serial I/O, XML parsing, and system services"
HOMEPAGE="http://www.gnu.org/software/commonc++/"
SRC_URI="mirror://gnu/commonc++/${P}.tar.gz
	mirror://gentoo/${P}-1.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -sparc ~ppc"
IUSE=""

DEPEND="sys-libs/zlib
	dev-libs/libxml2"

S="${WORKDIR}/${P/commonc/CommonC}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.1.patch || die "patch1 failed"
	if use ppc; then
		epatch ${DISTDIR}/${P}-1.diff.gz || die "patch2 failed"
	fi
}
src_compile() {
	econf || die "./configure failed"
	#Ugly hack the makefile looks a bit ill behaving
	cd src
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	#Ugly hack the makefile looks a bit ill behaving
	rm -fR ${D}/var
	dodoc AUTHORS INSTALL NEWS OVERVIEW.TXT ChangeLog \
		README THANKS TODO COPYING*
	dohtml doc/*
}
