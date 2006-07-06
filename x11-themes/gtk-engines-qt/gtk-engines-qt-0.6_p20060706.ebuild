# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-qt/gtk-engines-qt-0.6_p20060706.ebuild,v 1.2 2006/07/06 21:49:33 flameeyes Exp $

inherit kde

MY_P="gtk-qt-engine-${PV}"
DESCRIPTION="GTK+2 Qt Theme Engine"
HOMEPAGE="http://www.freedesktop.org/Software/gtk-qt"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${MY_P}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"

DEPEND="${DEPEND}
	>=x11-libs/gtk+-2.2"

need-kde 3
# Set slot after the need-kde. Fixes bug #78455.
SLOT="2"

S=${WORKDIR}/${MY_P}

PATCHES="${FILESDIR}/${P}-implicit.patch"
