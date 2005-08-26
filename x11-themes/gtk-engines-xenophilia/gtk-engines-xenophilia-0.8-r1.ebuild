# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-xenophilia/gtk-engines-xenophilia-0.8-r1.ebuild,v 1.12 2005/08/26 13:57:10 agriffis Exp $

DESCRIPTION="GTK+1 Xenophilia Theme Engine"
HOMEPAGE="http://themes.freshmeat.net/projects/xenophilia/"
SRC_URI="http://download.freshmeat.net/themes/xenophilia/xenophilia-${PV}.tar.gz"
KEYWORDS="alpha amd64 hppa ~ia64 ppc sparc x86"
LICENSE="LGPL-2"
SLOT="1"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	virtual/x11"

S=${WORKDIR}/Xenophilia-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	# disable fonts installation
	sed -i -e "s/\(SUBDIR.*\)fonts\(.*\)/\1\2/" Makefile.in
}

src_install() {
	einstall \
		THEME_DIR=${D}/usr/share/themes \
		ENGINE_DIR=${D}/usr/lib/gtk/themes/engines \
		|| die "Installation failed"

	dodoc AUTHORS BUGS CONFIGURATION ChangeLog README TODO

	# FIXME: install fonts
}
