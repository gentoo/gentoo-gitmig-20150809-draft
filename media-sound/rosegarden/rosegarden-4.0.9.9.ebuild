# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rosegarden/rosegarden-4.0.9.9.ebuild,v 1.2 2004/09/30 23:37:52 eradicator Exp $

IUSE="jack"

inherit eutils flag-o-matic

MY_PV="${PV/./-}"
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="MIDI and audio sequencer and notation editor."
HOMEPAGE="http://www.rosegardenmusic.com/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~x86 ~ppc ~amd64"
KEYWORDS="-*"

RDEPEND=">=kde-base/kdelibs-3.0
	>=x11-libs/qt-3
	media-libs/alsa-lib
	jack? ( media-sound/jack-audio-connection-kit )
	>=media-libs/ladspa-sdk-1.0
	>=media-libs/ladspa-cmt-1.14"

DEPEND="${RDEPEND}
	>=sys-devel/automake-1.7
	sys-devel/libtool"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc34.patch
	epatch ${FILESDIR}/${P}-pic.patch

	# Fix broken (-fPIC) tools
	libtoolize -f -c || die

	export WANT_AUTOMAKE=1.7
	export WANT_AUTOCONF=2.5
	aclocal || die
	automake || die
	autoconf || die
}

src_compile() {
	addwrite ${QTDIR}/etc/settings

	#append-flags -fexceptions

	econf `use_with jack` \
		--with-ladspa \
		|| die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO TRANSLATORS
}
