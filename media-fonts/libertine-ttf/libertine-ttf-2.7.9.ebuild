# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/libertine-ttf/libertine-ttf-2.7.9.ebuild,v 1.2 2008/01/23 18:24:24 armin76 Exp $

inherit font versionator

MY_PN="LinLibertineFont"
MY_P="${MY_PN}-$(get_version_component_range 1-2)"

DESCRIPTION="OpenType fonts from the Linux Libertine Open Fonts Project"
HOMEPAGE="http://linuxlibertine.sourceforge.net/"
SRC_URI="mirror://sourceforge/linuxlibertine/${MY_P}.tgz"

LICENSE="|| ( GPL-2 OFL )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~sparc ~x86"
IUSE=""

S="${WORKDIR}/${MY_PN}"
DOCS="Bugs ChangeLog.txt Readme"
FONT_SUFFIX="ttf"
FONT_S="${S}"
