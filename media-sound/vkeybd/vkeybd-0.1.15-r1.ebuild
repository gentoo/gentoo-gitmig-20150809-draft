# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vkeybd/vkeybd-0.1.15-r1.ebuild,v 1.2 2005/08/17 21:51:04 fvdpol Exp $

IUSE="alsa oss ladcca"

DESCRIPTION="A virtual MIDI keyboard for X"
HOMEPAGE="http://www.alsa-project.org/~iwai/alsa.html"
SRC_URI="http://www.alsa-project.org/~iwai/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"

DEPEND="alsa? ( >=media-libs/alsa-lib-0.5.0 )
	>=dev-lang/tk-8.3
	>=dev-lang/tcl-8.3
	virtual/x11
	ladcca? ( >=media-libs/ladcca-0.3.1 )"

S=${WORKDIR}/${PN}

src_compile() {
	TCL_VERSION=`echo 'puts [info tclversion]' | tclsh`

	local myconf="PREFIX=/usr"

	#vkeybd requires at least one of its USE_ variable to be set
	if use alsa ; then
		myconf="${myconf} USE_ALSA=1"
		use oss || myconf="${myconf} USE_AWE=0 USE_MIDI=0"
	else
		myconf="${myconf} USE_ALSA=0 USE_AWE=1 USE_MIDI=1"
	fi

	if use ladcca ; then
		myconf="${myconf} USE_LADCCA=1"
		sed -i "s/USE_LADCCA *=.*$/USE_LADCCA = 1/" ${S}/Makefile || \
			die "Error altering Makefile"
	fi

	make ${myconf} TCL_VERSION=$TCL_VERSION || die "Make failed."
}

src_install() {
	make DESTDIR=${D} TCL_VERSION=$TCL_VERSION PREFIX=/usr install || \
		die "Installation Failed"
	make DESTDIR=${D} TCL_VERSION=$TCL_VERSION PREFIX=/usr install-man || \
		die "Man-Page Installation Failed"
	dodoc README
}
