# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-xfce/gtk-engines-xfce-2.1.9.ebuild,v 1.4 2004/07/15 01:06:36 agriffis Exp $

inherit gtk-engines2

IUSE=""

MY_P=${P/gtk-engines-xfce/gtk-xfce-engine}

S=${WORKDIR}/${MY_P}
DESCRIPTION="GTK+2 XFCE Theme Engine"
HOMEPAGE="http://xfce.sourceforge.net/"
SRC_URI="http://www.xfce.org/archive/xfce-4.0.4/src/${MY_P}.tar.gz
	mirror://gentoo/${MY_P}.tar.gz"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ia64 ppc ~sparc ~alpha ~hppa ~mips"

DEPEND=">=x11-libs/gtk+-2"
