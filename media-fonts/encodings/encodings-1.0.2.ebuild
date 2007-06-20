# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/encodings/encodings-1.0.2.ebuild,v 1.8 2007/06/20 19:45:08 corsair Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org font encodings"

KEYWORDS="alpha amd64 ~arm ~hppa ia64 ~m68k mips ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"

RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/mkfontscale"

CONFIGURE_OPTIONS="--with-encodingsdir=/usr/share/fonts/encodings"
