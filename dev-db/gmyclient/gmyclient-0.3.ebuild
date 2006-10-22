# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/gmyclient/gmyclient-0.3.ebuild,v 1.18 2006/10/22 16:49:03 vivo Exp $

inherit eutils

DESCRIPTION="Gnome based mysql client"
SRC_URI="http://${PN}.sourceforge.net/download/${P}.tar.gz"
HOMEPAGE="http://gmyclient.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc sparc x86"
IUSE="nls"

DEPEND=">=gnome-base/gnome-libs-1.2
		>=dev-db/mysql-3
		=gnome-base/libglade-0*
		media-libs/giflib"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-fix.patch || die "patch failed"
	epatch ${FILESDIR}/${PV}-gcc41.patch || die "patch failed"
}

src_compile() {
	econf $(use_enable nls) || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die "installed failed"
	dodoc AUTHORS README
	mv ${D}/usr/share/gmyclient/doc ${D}/usr/share/doc/${PF}/html
}
