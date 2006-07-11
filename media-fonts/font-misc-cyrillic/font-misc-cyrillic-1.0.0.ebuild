# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-misc-cyrillic/font-misc-cyrillic-1.0.0.ebuild,v 1.6 2006/07/11 15:19:32 agriffis Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular



DESCRIPTION="X.Org misc-cyrillic fonts"
KEYWORDS="~amd64 ~arm ~hppa ia64 ~ppc ppc64 ~s390 ~sparc ~x86"
RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/bdftopcf"
