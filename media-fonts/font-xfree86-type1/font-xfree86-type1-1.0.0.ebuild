# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-xfree86-type1/font-xfree86-type1-1.0.0.ebuild,v 1.10 2007/02/04 18:45:45 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular


DESCRIPTION="X.Org XFree86 Type 1 font"
KEYWORDS="~amd64 arm ~hppa ia64 ~ppc ppc64 s390 sh ~sparc ~x86 ~x86-fbsd"
RDEPEND=""
DEPEND="${RDEPEND}
	media-libs/fontconfig"
