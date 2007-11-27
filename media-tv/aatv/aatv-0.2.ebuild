# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/aatv/aatv-0.2.ebuild,v 1.4 2007/11/27 10:19:08 zzam Exp $

DESCRIPTION="watch TV on a text console rendered by aalib"
HOMEPAGE="http://n00n.free.fr/aatv/"
SRC_URI="http://n00n.free.fr/aatv/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND="media-libs/aalib"

src_install () {
	make DESTDIR="${D}" AATV_CONFIGFILE="${D}"/etc/${PN}.conf install || die

	dodoc AUTHORS NEWS README TODO
}
