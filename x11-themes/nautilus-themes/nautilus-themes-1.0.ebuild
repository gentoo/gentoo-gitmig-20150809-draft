# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/nautilus-themes/nautilus-themes-1.0.ebuild,v 1.6 2004/03/24 19:29:04 gustavoz Exp $

DESCRIPTION="Some nice themes for Nautilus"
S=${WORKDIR}
THEME_URI="http://ftp.gnome.org/pub/GNOME/teams/art.gnome.org/themes/nautilus/"
SRC_URI="${THEME_URI}Nautilus-Blue-Ripped.tar.bz2
	${THEME_URI}Nautilus-Conectiva-Crystal-1.2.tar.gz
	${THEME_URI}Nautilus-Freeicons-Ripped.tar.bz2
	${THEME_URI}Nautilus-Halloween-1.0.tar.gz
	${THEME_URI}Nautilus-Next-2.0.tar.gz
	${THEME_URI}Nautilus-NextStep.tar.gz
	${THEME_URI}Nautilus-ScalableGorilla-0.4.3.tar.bz2
	${THEME_URI}Nautilus-Snow-Apple-1.4.tar.gz
	${THEME_URI}Nautilus-Stylish.tar.gz
	${THEME_URI}Nautilus-World-of-Aqua-0.10.tar.gz
	${THEME_URI}Nautilus-Ximian-North-0.9.1.tar.gz
	${THEME_URI}Nautilus-Ximian-South-1.3.5.tar.gz"

HOMEPAGE="http://art.gnome.org/theme_list.php?category=nautilus"

DEPEND=""
RDEPEND="gnome-base/nautilus"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 amd64 sparc"
IUSE=""

src_unpack() {
	return 0
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dodir /usr/share/pixmaps/nautilus
	cd ${D}/usr/share/pixmaps/nautilus

	unpack ${A}

	chmod -R ugo=rX *
}
