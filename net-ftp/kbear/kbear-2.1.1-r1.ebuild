# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/kbear/kbear-2.1.1-r1.ebuild,v 1.1 2005/03/28 18:20:24 centic Exp $

inherit kde flag-o-matic eutils

DESCRIPTION="A KDE 3.x FTP Manager"
SRC_URI="mirror://sourceforge/kbear/${P}-1.src.tar.bz2"
HOMEPAGE="http://kbear.sourceforge.net/"

SLOT="0"
IUSE="gnome"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~amd64"
S=${WORKDIR}/kbear-2.1

need-kde 3
src_unpack() {
	use amd64 && append-flags -fPIC
	kde_src_unpack
	cd ${S}
	useq arts || epatch ${FILESDIR}/${P}-configure.patch
	epatch ${FILESDIR}/${P}-gcc-3.4.patch
}

GNOME_ICONS_DIR="/usr/share/pixmaps"
GNOME_LINKS_DIR="/usr/share/applications"

src_install()
{
	einstall || die

	# Kbear's Makefile already installs icons for KDE, so we just need install it for Gnome

	if [ -n "`use gnome`" ]
	then
		einfo "Installing menu entry and icons for Gnome"
		dodir ${GNOME_ICONS_DIR} ${GNOME_LINKS_DIR}
		cp ${S}/pics/hi48_app_kbear.png ${D}/${GNOME_ICONS_DIR}/kbear.png
		cp ${S}/kbear/kbear.desktop ${D}/${GNOME_LINKS_DIR}
		echo "Categories=Application;Network;" >>${D}/${GNOME_LINKS_DIR}/kbear.desktop
		echo "Comment[es_ES]=Un cliente FTP grafico" >>${D}/$GNOME_LINKS_DIR}/kbear.desktop
	fi
}
