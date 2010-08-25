# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wildmidi/wildmidi-0.2.3.4.ebuild,v 1.6 2010/08/25 18:17:11 maekke Exp $

EAPI=3

inherit base autotools

DESCRIPTION="Midi processing library and a midi player using the gus patch set"
HOMEPAGE="http://wildmidi.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="alsa debug"

RDEPEND="alsa? ( media-libs/alsa-lib )"
DEPEND="${RDEPEND}"

src_prepare() {
	#Respect LDFLAGS. Reported upstream. Bug id: 3045017
	sed -i -e "/^LDFLAGS/s:=:=\"${LDFLAGS}\":" configure.ac || die
	eautoreconf
}

src_configure() {
	econf \
		--disable-werror \
		$(use_enable debug) \
		$(use alsa || echo --with-oss)
}

src_install() {
	base_src_install
	find "${D}" -name '*.la' -exec rm -f {} +
}
