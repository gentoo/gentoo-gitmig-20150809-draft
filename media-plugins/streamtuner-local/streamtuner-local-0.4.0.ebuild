# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/streamtuner-local/streamtuner-local-0.4.0.ebuild,v 1.1 2004/04/09 04:50:29 eradicator Exp $

DESCRIPTION="A plugin for Streamtuner to browse and play local files."
SRC_URI="http://savannah.nongnu.org/download/streamtuner/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/streamtuner/"

IUSE="oggvorbis"
SLOT="0"
KEYWORDS="~x86"
LICENSE="BSD"

RDEPEND=">=net-misc/streamtuner-0.12.0
	>=media-libs/libid3tag-0.15
	oggvorbis? ( media-libs/libvorbis )"

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README INSTALL
}
