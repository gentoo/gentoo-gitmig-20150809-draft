# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-xenophilia/gtk-engines-xenophilia-0.8-r1.ebuild,v 1.5 2004/01/10 14:16:57 gustavoz Exp $

inherit gtk-engines2

IUSE=""
DESCRIPTION="GTK+1 Xenophilia Theme Engine"
HOMEPAGE="http://themes.freshmeat.net/projects/xenophilia/"
SRC_URI="http://download.freshmeat.net/themes/xenophilia/xenophilia-${PV}.tar.gz"
KEYWORDS="x86 ~ppc sparc ~alpha hppa"
LICENSE="GPL-2"
SLOT="1"

DEPEND="=x11-libs/gtk+-1.2*
	dev-util/pkgconfig"

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

	dodoc ${DEFAULT_DOCS}

	# FIXME: install fonts
}
