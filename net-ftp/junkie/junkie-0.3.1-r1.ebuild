# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/junkie/junkie-0.3.1-r1.ebuild,v 1.2 2005/01/19 01:31:52 mr_bones_ Exp $

inherit gnome2

S=${WORKDIR}/${PN}${PV}
DESCRIPTION="Junkie - GTK2 FTP Client"
SRC_URI="mirror://sourceforge/${PN}/${PN}${PV}.tar.bz2"
HOMEPAGE="http://sourceforge.net/projects/junkie"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ~ppc ~sparc"

DEPEND=">=x11-libs/gtk+-2.0.3
	>=dev-libs/glib-2.0.0"

src_install() {
	# Files "AUTHORS" and "COPYING" should also be here, but they are empty and dodoc can do nothing with them

	GNOME_LINKS_DIR="/usr/share/applications"
	GNOME_ICONS_DIR="/usr/share/pixmaps"

	ICONS="logo.png logo.gif logo.jpg"
	emake install DESTDIR=${D} || die "ERROR: I cannot install ${P}"

	if use gnome;
	then
		dodir ${GNOME_LINKS_DIR} ${GNOME_ICONS_DIR}
		einfo "Installing Gnome icons in ${GNOME_ICONS_DIR}"
		for x in ${ICONS}
		do
			cp ${S}/$x ${D}/${GNOME_ICONS_DIR}/junkie-$x
		done

		cp ${FILESDIR}/junkie.desktop ${D}/${GNOME_LINKS_DIR}
	fi

	KDE_LINKS_DIR="/usr/share/applnk/Internet"
	KDE_ICONS_DIR="${KDEDIR}/share/icons/default.kde"

	if use kde;
	then
		dodir ${KDE_LINKS_DIR} ${KDE_ICONS_DIR}
		einfo "Installing KDE icons in default theme"
		for x in ${ICONS}
		do
			cp ${S}/$x ${D}/${KDE_ICONS_DIR}/junkie-$x
		done
		cp ${FILESDIR}/junkie.desktop ${D}/${KDE_LINKS_DIR}
	fi

	dodoc ChangeLog INSTALL NEWS README
}
