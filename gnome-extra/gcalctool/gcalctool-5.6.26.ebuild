# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gcalctool/gcalctool-5.6.26.ebuild,v 1.1 2005/08/20 14:47:58 allanonjl Exp $

inherit gnome2 eutils

DESCRIPTION="A scientific calculator for Gnome2"
HOMEPAGE="http://calctool.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gconf-1.2
	>=dev-libs/atk-1.6"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	app-text/scrollkeeper
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README TODO"
USE_DESTDIR=1

src_unpack() {
	unpack ${A}
	cd ${S}

	# blah, someone should make a patch to send upstream
	gnome2_omf_fix 	help/C/Makefile.in \
					help/de/Makefile.in \
					help/es/Makefile.in \
					help/fr/Makefile.in \
					help/ja/Makefile.in \
					help/it/Makefile.in \
					help/ko/Makefile.in \
					help/sv/Makefile.in \
					help/zh_CN/Makefile.in \
					help/zh_HK/Makefile.in \
					help/zh_TW/Makefile.in
}

src_install() {

	gnome2_src_install

	# remove symlink that conflicts with <2.3 gnome-utils
	rm -f ${D}/usr/bin/gnome-calculator
}
