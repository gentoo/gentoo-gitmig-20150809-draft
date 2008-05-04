# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ksubtitleripper/ksubtitleripper-0.3.1.ebuild,v 1.2 2008/05/04 14:13:34 drac Exp $

inherit kde

DESCRIPTION="Graphical frontend to subtitleripper"
HOMEPAGE="http://ksubtitleripper.berlios.de/"
SRC_URI="mirror://berlios/ksubtitleripper/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""
RDEPEND="media-video/subtitleripper"

need-kde 3

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-menu1-gentoo.diff \
		"${FILESDIR}"/${PV}-menu2-gentoo.diff
}
