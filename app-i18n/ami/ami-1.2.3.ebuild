# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ami/ami-1.2.3.ebuild,v 1.5 2004/11/23 08:42:17 usata Exp $

inherit eutils

IUSE="gtk2"

DESCRIPTION="Korean IMS Ami"
SRC_URI="http://download.kldp.net/ami/${P}.tar.gz
	http://ami.kldp.net/hanja.dic.gz"
HOMEPAGE="http://ami.kldp.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc"

DEPEND="!gtk2 ( >=media-libs/gdk-pixbuf-0.7.0 )"

src_unpack() {
	unpack ${P}.tar.gz
	use gtk2 && epatch ${FILESDIR}/${P}-imhangul_status.patch
}

src_compile() {

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {

	make DESTDIR=${D} install || die

	gzip -d -c ${DISTDIR}/hanja.dic.gz > ${D}/usr/share/ami/hanja.dic
	dodoc AUTHORS COPYING* ChangeLog INSTALL README README.en NEWS THANKS
}
