# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/audacious-crossfade/audacious-crossfade-0.3.11.ebuild,v 1.1 2006/10/28 23:08:35 vericgar Exp $

inherit eutils

IUSE="libsamplerate"
U_PN="xmms-crossfade"

DESCRIPTION="Audacious plugin for crossfading and continuous output. Also know
as xmms-crossfade"
HOMEPAGE="http://www.eisenlohr.org/xmms-crossfade/index.html"
SRC_URI="http://www.eisenlohr.org/${U_PN}/${U_PN}-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="media-sound/audacious
		libsamplerate? ( media-libs/libsamplerate )"

S="${WORKDIR}/${U_PN}-${PV}"

src_compile() {
	myconf=$(use_enable libsamplerate samplerate)
	myconf="${myconf} --enable-player=audacious"

	econf ${myconf} || die
	emake || die
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
