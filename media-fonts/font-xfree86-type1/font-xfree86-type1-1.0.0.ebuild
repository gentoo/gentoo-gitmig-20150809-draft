# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-xfree86-type1/font-xfree86-type1-1.0.0.ebuild,v 1.6 2006/07/02 19:07:36 corsair Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular


DESCRIPTION="X.Org XFree86 Type 1 font"
RESTRICT="mirror"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ppc64 ~s390 ~sparc ~x86"
RDEPEND=""
DEPEND="${RDEPEND}
	media-libs/fontconfig"
