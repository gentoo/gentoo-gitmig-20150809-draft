# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/hfsutils/hfsutils-3.2.6-r4.ebuild,v 1.1 2005/02/05 21:20:43 hansmi Exp $

inherit eutils

DESCRIPTION="HFS FS Access utils"
HOMEPAGE="http://www.mars.org/home/rob/proj/hfs/"
SRC_URI="ftp://ftp.mars.org/pub/hfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~ppc64"
IUSE="tcltk"

DEPEND="virtual/libc
	tcltk? ( dev-lang/tcl dev-lang/tk )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/hfsutils-3.2.6-errno.patch
	epatch ${FILESDIR}/largerthan2gb.patch
}

src_compile() {
	local myconf
	use tcltk && myconf="--with-tcl --with-tk"

	econf ${myconf} || die
	emake PREFIX=/usr MANDIR=/usr/share/man || die
	cd ${S}/hfsck
	emake PREFIX=/usr MANDIR=/usr/share/man || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/lib
	dodir /usr/share/man/man1
	cd ${S}
	make \
		prefix=${D}/usr \
		MANDEST=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
	cd ${S}/hfsck
	install -m0755 hfsck ${D}/usr/bin/
	cd ${S}
}
