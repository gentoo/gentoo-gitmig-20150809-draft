# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacity/audacity-1.1.3.ebuild,v 1.1 2003/04/12 08:03:15 jje Exp $

inherit eutils

DESCRIPTION="A free, crossplatform audio editor."
HOMEPAGE="http://audacity.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.tgz"

LICENSE="GPL-2"
IUSE="encode oggvorbis"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=x11-libs/wxGTK-2.2.9
	>=app-arch/zip-2.3
	>=media-sound/mad-0.14
	>=media-libs/id3lib-3.8.0
	>=media-libs/libsndfile-1.0.0
        >=media-libs/libsamplerate-0.0.14
	>=dev-libs/fftw-2.1.3
        >=media-libs/ladspa-sdk-1.12
	oggvorbis? ( >=media-libs/libvorbis-1.0 )
        encode? ( >=media-sound/lame-3.92 )"

S="${WORKDIR}/${PN}-src-${PV}"

src_unpack() {
	if [ `use gtk2` ]; then
		eerror ""
		eerror "Audacity will not build with wxGTK compiled"
		eerror "against gtk2.  Make sure you have set"
		eerror "-gtk2 in use for this program to compile"
		eerror ""
		die "Make sure -gtk2 is in USE"
	fi		
	unpack ${PN}-src-${PV}.tgz
}

src_compile() {
	econf --with-libsndfile=system --without-libflac || die
	MAKEOPTS=-j1 emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc LICENSE.txt README.txt
}
