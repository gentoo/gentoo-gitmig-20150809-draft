# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/bio2jack/bio2jack-0.3-r1.ebuild,v 1.4 2004/10/17 02:07:35 kloeri Exp $

IUSE="static"

inherit libtool

DESCRIPTION="A library for porting blocked I/O OSS/ALSA audio applications to JACK."
HOMEPAGE="http://bio2jack.sourceforge.net/"
SRC_URI="mirror://sourceforge/bio2jack/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc ~alpha"
RDEPEND=">=media-sound/jack-audio-connection-kit-0.80"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.50"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	export WANT_AUTOMAKE=1.8
	export WANT_AUTOCONF=2.5
	aclocal || die
	automake || die
	autoconf || die
	elibtoolize || die
}

src_compile() {
	econf `use_enable static` || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dobin bio2jack-config
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
