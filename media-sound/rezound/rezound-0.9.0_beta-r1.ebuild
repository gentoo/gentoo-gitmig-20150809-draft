# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rezound/rezound-0.9.0_beta-r1.ebuild,v 1.3 2004/07/24 05:53:23 eradicator Exp $

inherit eutils

MY_P="${P/_/}"
DESCRIPTION="Sound editor and recorder"
HOMEPAGE="http://rezound.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

IUSE="oggvorbis jack nls static oss cdr"

RDEPEND="virtual/x11
	jack? ( media-sound/jack-audio-connection-kit )
	oggvorbis? ( media-libs/libvorbis media-libs/libogg )
	cdr? ( app-cdr/cdrdao )
	=dev-libs/fftw-2*
	>=x11-libs/fox-1.2.4
	>=media-libs/ladspa-sdk-1.12
	>=media-libs/ladspa-cmt-1.15
	>=media-libs/portaudio-18
	>=media-libs/flac-1.1.0"

DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake"

S="${WORKDIR}/${MY_P}"


src_unpack() {
	unpack ${A} || die
	epatch ${FILESDIR}/${P}-libfox1.2-makefiles.patch.gz
	epatch ${FILESDIR}/${P}-libfox1.2-code.patch.gz

	cd ${S}
	./bootstrap || die
}


src_compile() {
	local myconf="--prefix=/usr --host=${CHOST} --with-gnu-ld"
	use jack || myconf="${myconf} --disable-jack"
	use static && myconf="${myconf} --enable-standalone"
	use oss && myconf="${myconf} --enable-oss"
	use nls || myconf="${myconf} --disable-nls"

	./configure ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc docs/AUTHORS docs/COPYING docs/CVS-INSTALL docs/Features.txt docs/FrontendFoxFeatures.txt
	dodoc docs/INSTALL docs/NEWS docs/README docs/README_DOCS docs/TODO_FOR_USERS_TO_READ
}

