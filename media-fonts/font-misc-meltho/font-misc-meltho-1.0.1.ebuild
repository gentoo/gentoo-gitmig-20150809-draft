# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-misc-meltho/font-misc-meltho-1.0.1.ebuild,v 1.5 2010/07/22 15:25:49 maekke Exp $

FONT_DIR="OTF"

EAPI=3
inherit xorg-2

DESCRIPTION="X.Org Syriac fonts"

KEYWORDS="~alpha amd64 arm hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/bdftopcf"
