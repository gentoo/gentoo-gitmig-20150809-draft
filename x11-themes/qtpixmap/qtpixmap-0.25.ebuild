# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/qtpixmap/qtpixmap-0.25.ebuild,v 1.3 2003/08/31 12:57:43 obz Exp $

inherit gtk-engines2 eutils

MY_PN="QtPixmap"

IUSE=""
DESCRIPTION="A modifed version of the original GTK pixmap engine which follows the KDE color scheme"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=7043"
SRC_URI="http://www.kde-look.org/content/files/7043-${MY_PN}-${PV}.tar.gz"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
LICENSE="GPL-2"
SLOT="2"

DEPEND="$DEPEND >=media-libs/imlib-1.8
        dev-util/pkgconfig
        =x11-libs/gtk+-1.2*"

S=${WORKDIR}/${MY_PN}-${PV}

