# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/freealut/freealut-1.1.0.ebuild,v 1.1 2006/07/05 16:31:05 wolf31o2 Exp $

inherit eutils gnuconfig

DESCRIPTION="The OpenAL Utility Toolkit"
SRC_URI="http://www.openal.org/openal_webstf/downloads/${P}.tar.gz"
HOMEPAGE="http://www.openal.org"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="~media-libs/openal-0.0.8
	!~media-libs/openal-20050504"

src_compile() {
	econf \
		--libdir=/usr/$(get_libdir) || die
	emake all || die
}

src_install() {
	make install DESTDIR="${D}" || die

	dodoc AUTHORS ChangeLog NEWS README
	dohtml doc/*
}
