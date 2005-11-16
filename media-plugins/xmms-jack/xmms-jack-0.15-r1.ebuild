# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-jack/xmms-jack-0.15-r1.ebuild,v 1.1 2005/11/16 15:40:48 metalgod Exp $

IUSE=""

inherit eutils libtool autotools

S="${WORKDIR}/${PN}"

DESCRIPTION="a jack audio output plugin for XMMS"
HOMEPAGE="http://xmms-jack.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc ~x86 ppc64"

RDEPEND="media-sound/xmms
	>=media-libs/bio2jack-0.4
	media-sound/jack-audio-connection-kit"

DEPEND="${RDEPEND}
	=sys-devel/automake-1.8*
	=sys-devel/autoconf-2.5*"

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
