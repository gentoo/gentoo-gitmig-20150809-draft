# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-xfce/gtk-engines-xfce-2.1.6.ebuild,v 1.5 2004/01/08 17:37:58 gustavoz Exp $

inherit gtk-engines2

IUSE=""

MY_P=${P/gtk-engines-xfce/gtk-xfce-engine}

S=${WORKDIR}/${MY_P}
DESCRIPTION="GTK+2 XFCE Theme Engine"
HOMEPAGE="http://xfce.sourceforge.net/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ~ia64 ~ppc sparc ~alpha hppa"

DEPEND=">=x11-libs/gtk+-2"
