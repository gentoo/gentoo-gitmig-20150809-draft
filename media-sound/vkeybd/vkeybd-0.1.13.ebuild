# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vkeybd/vkeybd-0.1.13.ebuild,v 1.1 2003/04/22 17:45:46 utx Exp $

DESCRIPTION="A virtual MIDI keyboard for X."
HOMEPAGE="http://www.alsa-project.org/~iwai/alsa.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="alsa oss ladcca"

DEPEND="alsa? ( >=media-libs/alsa-lib-0.5.0 )
	>=dev-lang/tk-8.3
	>=dev-lang/tcl-8.3
	virtual/x11
	ladcca? ( media-libs/ladcca )"

SRC_URI="http://www.alsa-project.org/~iwai/${P}.tar.gz"
S=${WORKDIR}/${PN}
TCL_VERSION=`awk -F\' '/TCL_VERSION/ {print $2}' /usr/lib/tclConfig.sh`

src_unpack() {
	unpack ${A} || die
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-Makefile.passvariables.patch || die \
		"Patch #1 failed"
}

src_compile() {
	local myconf="PREFIX=/usr"

	#vkeybd requires at least one of its USE_ variable to be set
	if [ "`use alsa`" ]; then
		myconf="${myconf} USE_ALSA=1"
		use oss || myconf="${myconf} USE_AWE=0 USE_MIDI=0"
	else
		myconf="${myconf} USE_ALSA=0 USE_AWE=1 USE_MIDI=1"
	fi
	if [ "`use ladcca`" ]; then
		myconf="${myconf} USE_LADCCA=1"
	fi

	make ${myconf} TCL_VERSION=$TCL_VERSION || die "Make failed."
}

src_install() {
	make DESTDIR=${D} PREFIX=/usr install || die "Installation Failed"
	make DESTDIR=${D} PREFIX=/usr install-man || die \
					    "Man-Page Installation Failed"
	dodoc README
}
