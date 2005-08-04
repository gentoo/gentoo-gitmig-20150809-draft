# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/experience/experience-3.03.ebuild,v 1.1 2005/08/04 07:29:45 leonardop Exp $

DESCRIPTION="GTK+2 themes which copy and improve the look of XP Luna"
HOMEPAGE="http://art.gnome.org/themes/gtk2/1058"
SRC_URI="http://art.gnome.org/download/themes/gtk2/1058/GTK2-EXperience.tar.gz"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="x11-themes/gtk-engines-experience"

src_unpack() {
	unpack ${A}

	cd ${WORKDIR}
	mv "eXperience - ice" eXperience-ice
	mv "eXperience - olive" eXperience-olive

	# Don't install index files, since this package doesn't provide the icon
	# set. Remove cruft files also.
	find . -name '*~' | xargs rm -f
	find . -name index.theme | xargs rm -f
}

src_compile() {
	return 0
}

src_install() {
	cd ${WORKDIR}
	for dir in eXperience* ; do
		insinto "/usr/share/themes/${dir}"
		doins -r ${dir}/*
	done

	dodoc eXperience/README
}
