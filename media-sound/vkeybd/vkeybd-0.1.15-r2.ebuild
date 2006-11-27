# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vkeybd/vkeybd-0.1.15-r2.ebuild,v 1.3 2006/11/27 00:23:37 malc Exp $

inherit toolchain-funcs eutils

IUSE="alsa oss ladcca"

DESCRIPTION="A virtual MIDI keyboard for X"
HOMEPAGE="http://www.alsa-project.org/~iwai/alsa.html"
SRC_URI="http://www.alsa-project.org/~iwai/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"

RDEPEND="alsa? ( >=media-libs/alsa-lib-0.5.0 )
	>=dev-lang/tk-8.3
	ladcca? ( >=media-libs/ladcca-0.3.1 )
	|| ( x11-libs/libX11 virtual/x11 )"

DEPEND="${RDEPEND}
	|| ( ( x11-proto/xf86bigfontproto
			x11-proto/bigreqsproto
			x11-proto/xextproto
			x11-proto/xcmiscproto )
		virtual/x11 )"

S=${WORKDIR}/${PN}

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
	myconf="${myconf} CC=$(tc-getCC)"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	emake ${myconf} EXTRACFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "Make failed."
}

src_install() {
	emake ${myconf} DESTDIR="${D}" install-all || die "Installation Failed"
	dodoc README ChangeLog
}
