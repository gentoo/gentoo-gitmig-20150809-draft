# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/libertine-ttf/libertine-ttf-2.8.14.ebuild,v 1.9 2008/08/25 12:36:35 armin76 Exp $

inherit font versionator

MY_PN="LinLibertineFont"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="OpenType fonts from the Linux Libertine Open Fonts Project"
HOMEPAGE="http://linuxlibertine.sourceforge.net/"
SRC_URI="mirror://sourceforge/linuxlibertine/${MY_P}.tgz"

LICENSE="|| ( GPL-2-with-font-exception OFL )"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND=""
RDEPEND="!<x11-libs/pango-1.20.4"

S="${WORKDIR}/${MY_PN}"
DOCS="Bugs ChangeLog.txt Readme"
FONT_SUFFIX="ttf"
FONT_S="${S}"
