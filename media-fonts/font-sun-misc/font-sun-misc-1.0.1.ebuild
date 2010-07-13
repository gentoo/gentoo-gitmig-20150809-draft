# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-sun-misc/font-sun-misc-1.0.1.ebuild,v 1.3 2010/07/13 13:13:49 fauli Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="X.Org Sun fonts"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/bdftopcf"
