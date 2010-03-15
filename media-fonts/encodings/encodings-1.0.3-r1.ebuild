# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/encodings/encodings-1.0.3-r1.ebuild,v 1.1 2010/03/15 22:24:08 scarabeus Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

EAPI=3
inherit xorg-2

DESCRIPTION="X.Org font encodings"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/mkfontscale
	>=media-fonts/font-util-1.1.1-r1"

ECONF_SOURCE="${S}"
