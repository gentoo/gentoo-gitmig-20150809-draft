# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/freealut/freealut-1.0.1.ebuild,v 1.12 2009/03/11 20:29:46 tupone Exp $

inherit eutils

DESCRIPTION="The OpenAL Utility Toolkit"
SRC_URI="http://www.openal.org/openal_webstf/downloads/${P}.tar.gz"
HOMEPAGE="http://www.openal.org"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="media-libs/openal"
DEPEND="${RDEPEND}"

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
