# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/ami/ami-1.2.2.ebuild,v 1.3 2004/01/24 11:44:41 pyrania Exp $

IUSE="gtk2"
S=${WORKDIR}/${P}
DESCRIPTION="Korean IMS Ami"
SRC_URI="http://download.kldp.net/ami/${P}.tar.gz
	http://ami.kldp.net/hanja.dic.gz
	gtk2? (http://www.gentoo.or.kr/~jayskwak/patch/${P}-imhangul_status.patch)"
HOMEPAGE="http://ami.kldp.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"

DEPEND="!gtk2 ( >=media-libs/gdk-pixbuf-0.7.0 )"

src_unpack() {
	unpack ${P}.tar.gz
	if [ -n "`use gtk2`" ]
	then
		epatch ${DISTDIR}/${P}-imhangul_status.patch
	fi
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die

}

src_install() {
	einstall || die

	gzip -d -c ${DISTDIR}/hanja.dic.gz > ${D}/usr/share/ami/hanja.dic
	dodoc AUTHORS COPYING* ChangeLog INSTALL README README.en NEWS THANKS
}
