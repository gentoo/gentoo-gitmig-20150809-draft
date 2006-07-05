# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/bio2jack/bio2jack-0.7.ebuild,v 1.7 2006/07/05 06:13:01 vapier Exp $

inherit libtool

DESCRIPTION="A library for porting blocked I/O OSS/ALSA audio applications to JACK"
HOMEPAGE="http://bio2jack.sourceforge.net/"
SRC_URI="mirror://sourceforge/bio2jack/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~ppc ~ppc-macos ppc64 sh sparc ~x86"
IUSE=""

RDEPEND=">=media-sound/jack-audio-connection-kit-0.80"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.50"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	export WANT_AUTOMAKE=1.8
	export WANT_AUTOCONF=2.5
	aclocal || die
	automake || die
	autoconf || die
	libtoolize --copy --force ||die
	elibtoolize || die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dobin bio2jack-config || die
	dodoc AUTHORS ChangeLog NEWS README
}
