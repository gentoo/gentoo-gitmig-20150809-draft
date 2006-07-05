# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/dvbtune/dvbtune-0.5.ebuild,v 1.2 2006/07/05 07:53:14 mr_bones_ Exp $

inherit eutils

DESCRIPTION="simple tuning app for DVB cards"
HOMEPAGE="http://sourceforge.net/projects/dvbtools"
SRC_URI="mirror://sourceforge/dvbtools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="xml"

RDEPEND="xml? ( dev-libs/libxml2 )"
DEPEND="${RDEPEND}
		media-tv/linuxtv-dvb-headers"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	emake dvbtune

	use xml && emake xml2vdr
}

src_install() {
	dobin dvbtune

	use xml && dobin xml2vdr

	dodoc README scripts/*
}

