# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/ee/ee-0.3.12-r3.ebuild,v 1.1 2004/12/07 10:20:21 hattya Exp $

inherit gnuconfig eutils

IUSE="nls"

DESCRIPTION="ee"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND="=sys-libs/db-1*
	>=gnome-base/gnome-libs-1.4.1.2-r1"
RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-mo.diff || die "epatch failed!"
}

src_compile() {
	gnuconfig_update

	local myconf
	use nls && myconf="--enable-nls" || myconf="--disable-nls"

	econf ${myconf} || die "configure failure"
	emake || die "make failure"
}

src_install() {
	make DESTDIR=${D} \
	     prefix=/usr \
	     install || die "make install failure"
	dodoc AUTHORS COPYING ChangeLog NEWS README

	# ee -> eeyes (bug #73179)
	# based on official Debian package's control file 
	mv ${D}/usr/bin/{ee,eeyes}
	mv ${D}/usr/bin/{ee,eeyes}
	mv ${D}/usr/share/gnome/help/{ee,eeyes}

	sed 's:\(=ee\):\1yes:' ${D}/usr/share/mime-info/ee.keys \
		> ${D}/usr/share/mime-info/eeyes.keys
	rm ${D}/usr/share/mime-info/ee.keys

	sed 's:\(Exec=ee\):\1yes:' ${D}/usr/share/gnome/apps/Graphics/ee.desktop \
		> ${D}/usr/share/gnome/apps/Graphics/eeyes.desktop
	rm ${D}/usr/share/gnome/apps/Graphics/ee.desktop
}
