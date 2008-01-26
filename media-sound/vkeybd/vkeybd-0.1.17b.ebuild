# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vkeybd/vkeybd-0.1.17b.ebuild,v 1.1 2008/01/26 22:17:03 aballier Exp $

inherit toolchain-funcs eutils

IUSE="alsa oss ladcca"

DESCRIPTION="A virtual MIDI keyboard for X"
HOMEPAGE="http://www.alsa-project.org/~iwai/alsa.html"
SRC_URI="http://www.gtlib.gatech.edu/pub/suse/people/tiwai/vkeybd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"

RDEPEND="alsa? ( >=media-libs/alsa-lib-0.5.0 )
	>=dev-lang/tk-8.3
	ladcca? ( >=media-libs/ladcca-0.3.1 )
	x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xf86bigfontproto
	x11-proto/bigreqsproto
	x11-proto/xextproto
	x11-proto/xcmiscproto"

S="${WORKDIR}"/${PN}

pkg_setup() {
	TCL_VERSION=`echo 'puts [info tclversion]' | tclsh`

	myconf="PREFIX=/usr"

	#vkeybd requires at least one of its USE_ variable to be set
	if use alsa ; then
		myconf="${myconf} USE_ALSA=1"
		use oss || myconf="${myconf} USE_AWE=0 USE_MIDI=0"
	else
		myconf="${myconf} USE_ALSA=0 USE_AWE=1 USE_MIDI=1"
	fi

	if use ladcca ; then
		myconf="${myconf} USE_LADCCA=1"
	fi

	myconf="${myconf} TCL_VERSION=${TCL_VERSION}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_compile() {
	tc-export CC
	emake ${myconf} COPTFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "emake failed."
}

src_install() {
	emake ${myconf} DESTDIR="${D}" install-all || die "emake install failed."
	dodoc README ChangeLog
}
