# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/pikdev/pikdev-0.9.2.1.ebuild,v 1.7 2009/11/11 12:33:47 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde versionator

MY_P=${PN}-$(replace_version_separator 3 '-' )
DESCRIPTION="Graphical IDE for PIC-based application development"
HOMEPAGE="http://pikdev.free.fr/"
SRC_URI="http://pikdev.free.fr/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE=""
S="${WORKDIR}/${MY_P}"

RDEPEND="dev-embedded/gputils"

need-kde 3

src_unpack() {
	kde_src_unpack
	cd "${S}"

	# Do not install .desktop file, it's misplaced and useless
	sed -i -e "s:install-shelldesktopDATA install-shellrcDATA:install-shellrcDATA:" \
		src/Makefile.in || die "sed failed"

	# Fix compilation with gcc 4.3, bug #227501
	sed -i -e '/^#include <iomanip>/ a\
#include <cstring>' src/pkp.cc || die "sed failed"
}

src_install() {
	kde_src_install all
	make_desktop_entry pikdev PiKdev /usr/share/icons/hicolor/32x32/apps/pikdev.png
}
