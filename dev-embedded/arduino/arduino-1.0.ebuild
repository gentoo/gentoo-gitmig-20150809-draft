# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/arduino/arduino-1.0.ebuild,v 1.2 2012/02/10 00:50:47 miknix Exp $

EAPI=3
inherit eutils

DESCRIPTION="Arduino is an open-source AVR electronics prototyping platform"
HOMEPAGE="http://arduino.cc/"
SRC_URI="x86?   ( http://arduino.googlecode.com/files/${P}-linux.tgz )
		 amd64? ( http://arduino.googlecode.com/files/${P}-linux64.tgz )"

LICENSE="GPL-2 LGPL-2 CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT="strip binchecks"
IUSE="+java"
RDEPEND="dev-embedded/avrdude
	sys-devel/crossdev"
DEPEND="${RDEPEND} java? (
	virtual/jre
	dev-embedded/uisp
	dev-java/jikes
	dev-java/jna
	>=dev-java/rxtx-2.2_pre2 )"

pkg_postinst() {
	ewarn "PLEASE NOTICE:"
	if [ ! -x /usr/bin/avr-g++ ]; then
		ewarn "avr-g++ is missing, if you need a toolchain please see"
		ewarn "http://en.gentoo-wiki.com/wiki/Crossdev#AVR_Architecture"
		ewarn ""
	fi
	ewarn "You will need >=cross-avr/gcc-4.4.1 if you intend to use the new"
	ewarn "Arduino Mega 2560."
}

src_prepare() {
	# avrdude has it's own ebuild
	rm -rf hardware/tools/avrdude*

	# fix deprecated prog_char usage in Print.cpp (#303043)
	epatch "${FILESDIR}"/${P}-prog_char-fix.patch

	# -java don't build IDE
	if ! use java; then
		rm -rf lib
		rm -f arduino
	else
		# fix the provided arduino script to call out the right
		# libraries, remove resetting of $PATH, and fix its
		# reference to LD_LIBRARY_PATH (see bug #189249)
		epatch "${FILESDIR}"/${P}-script.patch
	fi
}

src_install() {
	mkdir -p "${D}/usr/share/${P}/" "${D}/usr/bin"
	cp -a "${S}" "${D}/usr/share/" || die "Copying failed"

	if use java; then
		sed -e s@__PN__@${P}@g < "${FILESDIR}"/arduino \
			> "${D}/usr/bin/arduino" && chmod +x "${D}/usr/bin/arduino" \
			|| die "Creating run script failed"

		# get rid of libraries provided by other packages
		rm -f "${D}/usr/share/${P}/lib/RXTXcomm.jar"
		rm -f "${D}/usr/share/${P}/lib/jna.jar"
		rm -f "${D}/usr/share/${P}/lib/librxtxSerial.so"
		rm -f "${D}/usr/share/${P}/lib/librxtxSerial64.so"
		rm -f "${D}/usr/share/${P}/lib/ecj.jar"

		# use system avrdude
		# patching class files is too hard
		dosym /usr/bin/avrdude "/usr/share/${P}/hardware/tools/avrdude" \
			|| die "Couldn't symlink system avrdude files"
		dosym /etc/avrdude.conf "/usr/share/${P}/hardware/tools/avrdude.conf" \
			|| die "Couldn't symlink system avrdude files"

		# install desktop icon
		mkdir -p "${D}"/usr/share/applications
		sed -e s@__P__@${P}@ < "${FILESDIR}"/arduino.desktop \
			> "${D}"/usr/share/applications/arduino.desktop \
			|| die "Failed to install desktop icon"
	fi
}
