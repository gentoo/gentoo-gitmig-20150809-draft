# Copyright 2008-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/arduino/arduino-0015.ebuild,v 1.1 2009/04/14 22:00:18 solar Exp $

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
DEPEND="${RDEPEND} sys-devel/crossdev java? ( virtual/jre dev-embedded/uisp dev-java/jikes dev-java/rxtx )"

pkg_setup() {
	[ ! -x /usr/bin/avr-gcc ] && ewarn "You need to crossdev -s4 avr"
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

		# use system avrdude
		# patching class files is too hard
		dosym /usr/bin/avrdude "/usr/share/${P}/hardware/tools/avrdude"
		dosym /etc/avrdude.conf "/usr/share/${P}/hardware/tools/avrdude.conf"

		# IDE tries to compile these libs at first start up
		fperms -R g+w "/usr/share/${P}/hardware/libraries"
	fi

}
