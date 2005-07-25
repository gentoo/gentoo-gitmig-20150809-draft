# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsnap/xsnap-1.4.3-r1.ebuild,v 1.1 2005/07/25 22:06:38 smithj Exp $

inherit eutils

DESCRIPTION="Program to interactively take a 'snapshot' of a region of the screen"
SRC_URI="ftp://ftp.ac-grenoble.fr/ge/Xutils/${P}.tar.bz2"
HOMEPAGE="ftp://ftp.ac-grenoble.fr/ge/Xutils/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.4-gentoo.patch
	epatch ${FILESDIR}/${PN}-this-should-be-fixed-updstream.patch
}

src_compile() {
	xmkmf || die "xmkmf failed"
	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	make DESTDIR=${D} install.man || die "make install.man failed"
	dodoc README INSTALL AUTHORS
}
