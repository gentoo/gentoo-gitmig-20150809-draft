# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wildmidi/wildmidi-0.2.3.4.ebuild,v 1.3 2010/08/14 20:13:10 hwoarang Exp $

EAPI=3

inherit base autotools

DESCRIPTION="Midi processing library and a midi player using the gus patch set"
HOMEPAGE="http://wildmidi.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug oss"

RDEPEND="media-libs/alsa-lib
	oss? ( media-libs/alsa-oss )"
DEPEND=""

src_prepare() {
	#Respect LDFLAGS. Reported upstream. Bug id: 3045017
	sed -i -e "/^LDFLAGS/s:=:=\"${LDFLAGS}\":" configure.ac || die
	eautoreconf
}

src_configure() {
	econf  \
	$(use_enable debug) $(use_with oss) \
	--disable-werror
}
