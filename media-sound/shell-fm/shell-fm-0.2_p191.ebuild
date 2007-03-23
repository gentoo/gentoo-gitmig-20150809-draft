# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/shell-fm/shell-fm-0.2_p191.ebuild,v 1.1 2007/03/23 20:31:03 pioto Exp $

DESCRIPTION="A lightweight console based player for Last.FM radio streams."
HOMEPAGE="http://nex.scrapping.cc/shell-fm/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="ao"

DEPEND="media-libs/libmad
	ao? ( media-libs/libao )"

S="${WORKDIR}/${PN}"

src_compile() {
	econf $(use_enable ao) || die 'econf failed'
	emake || die 'emake failed'
}

src_install() {
	emake DESTDIR="${D}" install || die 'emake install failed'
}
