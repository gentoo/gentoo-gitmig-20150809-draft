# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-xfce/gtk-engines-xfce-2.2.5.ebuild,v 1.2 2005/01/18 00:25:21 bcowan Exp $

inherit gtk-engines2

MY_P=${P/gtk-engines-xfce/gtk-xfce-engine}

S=${WORKDIR}/${MY_P}
DESCRIPTION="GTK+2 Xfce Theme Engine"
HOMEPAGE="http://xfce.sourceforge.net/"
SRC_URI="http://www.xfce.org/archive/xfce-4.2.0/src-bz2/${MY_P}.tar.bz2
	mirror://gentoo/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2"

