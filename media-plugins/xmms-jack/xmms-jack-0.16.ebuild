# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-jack/xmms-jack-0.16.ebuild,v 1.1 2006/02/19 17:36:48 metalgod Exp $

inherit eutils libtool autotools

DESCRIPTION="a jack audio output plugin for XMMS"
HOMEPAGE="http://xmms-jack.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="media-sound/xmms
	>=media-libs/bio2jack-0.7
	media-libs/libsamplerate
	media-sound/jack-audio-connection-kit"

DEPEND="${RDEPEND}
	=sys-devel/automake-1.8*
	=sys-devel/autoconf-2.5*"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	#quick endianess fix
	sed -i -e "s:FMT_S16_LE:FMT_S16_NE:g" jack.c
	export WANT_AUTOMAKE=1.8
	export WANT_AUTOCONF=2.5
	eautoreconf
	elibtoolize
}

src_compile() {
	econf --disable-static || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
