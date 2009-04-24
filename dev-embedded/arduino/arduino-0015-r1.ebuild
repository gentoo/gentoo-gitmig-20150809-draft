# Copyright 2008-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/arduino/arduino-0015-r1.ebuild,v 1.2 2009/04/24 22:55:42 nixphoeni Exp $

inherit eutils

DESCRIPTION="Arduino is an open-source AVR electronics prototyping platform"
HOMEPAGE="http://arduino.cc/"
SRC_URI="http://www.arduino.cc/files/${P}-linux.tgz"
LICENSE="GPL-2 LGPL-2 CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT="strip binchecks"
IUSE="java"
RDEPEND="dev-embedded/avrdude"
DEPEND="${RDEPEND} sys-devel/crossdev java? ( virtual/jre dev-embedded/uisp dev-java/jikes dev-java/rxtx dev-java/antlr )"

pkg_setup() {
	[ ! -x /usr/bin/avr-g++ ] && ewarn "Missing avr-g++; you need to crossdev -s4 avr"
}

pkg_postinst() {
	pkg_setup
	einfo "Copy /usr/share/${P}/hardware/cores/arduino/Makefile and edit it to suit the project"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/Makefile-${PV}.patch
	rm -rf hardware/tools/avrdude*
	if ! use java; then
		rm -rf lib
		rm -f arduino
	fi
}

src_install() {
	mkdir -p "${D}/usr/share/${P}/" "${D}/usr/bin"
	cp -a "${S}" "${D}/usr/share/"
	fowners -R root:uucp "/usr/share/${P}/hardware"
	if use java; then
		sed -e  s@__PN__@${P}@g < "${FILESDIR}"/arduino > "${D}/usr/bin/arduino"
		chmod +x "${D}/usr/bin/arduino"

		# get rid of libraries provided by other packages
		rm -f "${D}/usr/share/${P}/lib/RXTXcomm.jar"
		rm -f "${D}/usr/share/${P}/lib/librxtxSerial.so"
		rm -f "${D}/usr/share/${P}/lib/antlr.jar"

		# fix the provided arduino script to call out the right libraries
		sed -i -e 's@lib/antlr\.jar@$(java-config -dp antlr)@g' \
			-e 's@lib/RXTXcomm\.jar@$(java-config -dp rxtx-2)@g' "${D}/usr/share/${P}/arduino"
		# and fix its reference to LD_LIBRARY_PATH (see bug #189249)
		sed -i -e 's@^LD_LIBRARY_PATH=.*@LD_LIBRARY_PATH=$(java-config -di rxtx-2)${LD_LIBRARY_PATH+:$LD_LIBRARY_PATH}@' "${D}/usr/share/${P}/arduino"

		# use system avrdude
		# patching class files is too hard
		dosym /usr/bin/avrdude "/usr/share/${P}/hardware/tools/avrdude"
		dosym /etc/avrdude.conf "/usr/share/${P}/hardware/tools/avrdude.conf"

		# IDE tries to compile these libs at first start up
		fperms -R g+w "/usr/share/${P}/hardware/libraries"
	fi

}
