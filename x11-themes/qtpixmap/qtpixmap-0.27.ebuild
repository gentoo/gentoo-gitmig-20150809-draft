# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/qtpixmap/qtpixmap-0.27.ebuild,v 1.2 2004/02/02 03:19:30 avenj Exp $

inherit gtk-engines2 eutils

MY_PN="QtPixmap"

IUSE=""
DESCRIPTION="A modifed version of the original GTK pixmap engine which follows the KDE color scheme"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=7043"
SRC_URI="http://www.kde-look.org/content/files/7043-${MY_PN}-${PV}.tar.gz"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"
LICENSE="GPL-2"
SLOT="2"

DEPEND="${DEPEND}
	>=media-libs/imlib-1.8
	dev-util/pkgconfig
	=x11-libs/gtk+-1.2*"

S=${WORKDIR}/${MY_PN}-${PV}
