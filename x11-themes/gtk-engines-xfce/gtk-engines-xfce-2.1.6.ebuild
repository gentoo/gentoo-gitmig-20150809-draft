# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-xfce/gtk-engines-xfce-2.1.6.ebuild,v 1.3 2003/11/16 01:05:10 gmsoft Exp $

inherit gtk-engines2

IUSE=""

MY_P=${P/gtk-engines-xfce/gtk-xfce-engine}

S=${WORKDIR}/${MY_P}
DESCRIPTION="GTK+2 XFCE Theme Engine"
HOMEPAGE="http://xfce.sourceforge.net/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ~ia64 ~ppc ~sparc ~alpha hppa ~mips ~arm"

DEPEND=">=x11-libs/gtk+-2"
