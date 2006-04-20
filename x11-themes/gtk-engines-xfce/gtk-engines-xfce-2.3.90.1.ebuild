# Copyright 1999-2006 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-xfce/gtk-engines-xfce-2.3.90.1.ebuild,v 1.1 2006/04/20 06:25:45 dostrow Exp $

MY_P="gtk-xfce-engine-${PV}"
S="${WORKDIR}/${MY_P}"

inherit xfce44

xfce44_beta

DESCRIPTION="GTK+2 Xfce Theme Engine"
SRC_URI="http://www.xfce.org/archive/xfce-${XFCE_MASTER_VERSION}/src/${MY_P}${COMPRESS}"
HOMEPAGE="http://www.xfce.org/"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

SLOT="2"
LICENSE="GPL-2"

RDEPEND=">=x11-libs/gtk+-2.2
	dev-libs/atk
	>=dev-libs/glib-2
	x11-libs/cairo
	x11-libs/pango"
