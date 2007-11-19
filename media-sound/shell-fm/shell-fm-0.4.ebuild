# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/shell-fm/shell-fm-0.4.ebuild,v 1.2 2007/11/19 22:25:40 drac Exp $

inherit autotools

DESCRIPTION="A lightweight console based player for Last.FM radio streams."
HOMEPAGE="http://nex.scrapping.cc/shell-fm"
SRC_URI="http://nex.scrapping.cc/${PN}/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ao"

RDEPEND="media-libs/libmad
	ao? ( media-libs/libao )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	econf $(use_enable ao)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS NEWS TODO shell-fm.rc-example doc/*.txt
	insinto /usr/share/doc/${PF}/scripts
	doins scripts/{shell*,zcontrol}
}
