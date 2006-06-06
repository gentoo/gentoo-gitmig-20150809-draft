# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythphone/mythphone-0.19.ebuild,v 1.2 2006/06/06 03:36:27 halcy0n Exp $

inherit eutils mythtv-plugins

DESCRIPTION="Phone and video calls with SIP."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/mythplugins-${PV}.tar.bz2"
IUSE="festival"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="festival? ( app-accessibility/festival )"
DEPEND="${DEPEND}"

MTVCONF=$(use_enable festival)

src_unpack() {
	mythtv-plugins_src_unpack
	epatch "${FILESDIR}"/${P}-gcc41.patch
}
