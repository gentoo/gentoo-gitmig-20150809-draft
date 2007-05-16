# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dv2sub/dv2sub-0.2.ebuild,v 1.1 2007/05/16 06:50:33 sbriesen Exp $

inherit eutils

DESCRIPTION="extract info or subtitles from DV stream"
HOMEPAGE="http://dv2sub.sourceforge.net/"
SRC_URI="mirror://sourceforge/dv2sub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-libs/libdv"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO
}
