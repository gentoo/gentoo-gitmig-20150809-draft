# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-jis-misc/font-jis-misc-1.0.3.ebuild,v 1.1 2010/11/17 16:29:38 mgorny Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

EAPI=3
inherit xorg-2

DESCRIPTION="X.Org JIS (japanese) fonts"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/bdftopcf
	>=media-fonts/font-util-1.1.1-r1"
