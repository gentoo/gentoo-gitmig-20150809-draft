# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/streamtuner-local/streamtuner-local-0.4.0.ebuild,v 1.9 2004/09/22 20:23:58 eradicator Exp $

inherit eutils

DESCRIPTION="A plugin for Streamtuner to browse and play local files."
SRC_URI="http://savannah.nongnu.org/download/streamtuner/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/streamtuner/"

IUSE="oggvorbis"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64 ~sparc"
LICENSE="BSD"

DEPEND=">=net-misc/streamtuner-0.12.0
	>=media-libs/libid3tag-0.15
	oggvorbis? ( >=media-libs/libvorbis-1.0 >=media-libs/libogg-1.1 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc34.patch
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README INSTALL
}
