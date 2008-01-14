# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/audacious-crossfade/audacious-crossfade-0.3.12.ebuild,v 1.3 2008/01/14 14:22:30 joker Exp $

IUSE="libsamplerate"
U_PN="xmms-crossfade"

DESCRIPTION="Audacious plugin for crossfading and continuous output. Also know as xmms-crossfade"
HOMEPAGE="http://www.eisenlohr.org/xmms-crossfade/index.html"
SRC_URI="http://www.eisenlohr.org/${U_PN}/${U_PN}-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="=media-sound/audacious-1.3*
	libsamplerate? ( media-libs/libsamplerate )
	dev-util/pkgconfig"

S="${WORKDIR}/${U_PN}-${PV}"

src_compile() {

	econf \
	      --enable-player=audacious \
	      --libdir="`pkg-config audacious --variable=output_plugin_dir`" \
	      $(use_enable libsamplerate samplerate) \
	      || die

	emake || die
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
