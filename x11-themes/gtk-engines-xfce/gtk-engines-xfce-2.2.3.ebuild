# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-xfce/gtk-engines-xfce-2.2.3.ebuild,v 1.1 2004/12/14 21:50:48 bcowan Exp $

inherit gtk-engines2

MY_P=${P/gtk-engines-xfce/gtk-xfce-engine}

S=${WORKDIR}/${MY_P}
DESCRIPTION="GTK+2 Xfce Theme Engine"
HOMEPAGE="http://xfce.sourceforge.net/"
SRC_URI="http://www.xfce.org/archive/xfce-4.1.99.2/src/${MY_P}.tar.gz
	mirror://gentoo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2"

