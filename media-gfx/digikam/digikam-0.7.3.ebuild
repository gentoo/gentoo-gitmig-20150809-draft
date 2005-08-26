# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/digikam/digikam-0.7.3.ebuild,v 1.2 2005/08/26 23:28:10 agriffis Exp $

inherit kde

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A digital photo management application for KDE."
HOMEPAGE="http://digikam.sourceforge.net/"
SRC_URI="mirror://sourceforge/digikam/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86"
IUSE=""

DEPEND=">=media-libs/libgphoto2-2
	>=media-libs/libkexif-0.2.1
	media-libs/libkipi
	media-libs/imlib2
	media-libs/tiff
	sys-libs/gdbm"

need-kde 3.2
