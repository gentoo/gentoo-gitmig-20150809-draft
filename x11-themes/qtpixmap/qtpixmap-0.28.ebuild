# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/qtpixmap/qtpixmap-0.28.ebuild,v 1.5 2004/11/12 09:23:52 kloeri Exp $

inherit gtk-engines2 eutils

MY_PN="QtPixmap"

IUSE=""
DESCRIPTION="A modified version of the original GTK pixmap engine which follows the KDE color scheme"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=7043"
SRC_URI="http://www.cpdrummond.freeuk.com/${MY_PN}-${PV}.tar.gz"
KEYWORDS="x86 ~ppc sparc alpha ~amd64 ~mips"
LICENSE="GPL-2"
SLOT="2"

DEPEND="${DEPEND}
	>=media-libs/imlib-1.8
	dev-util/pkgconfig
	=x11-libs/gtk+-1.2*"

S=${WORKDIR}/${MY_PN}-${PV}
