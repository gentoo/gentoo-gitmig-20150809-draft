# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/qtopia-desktop-bin/qtopia-desktop-bin-1.7.0.ebuild,v 1.8 2007/01/24 03:33:55 genone Exp $

inherit rpm

REV=-1
QD="/opt/Qtopia"
S="${WORKDIR}"

DESCRIPTION="Qtopia Deskyop sync application for Zaurus PDA's"
SRC_URI="ftp://ftp.trolltech.com/qtopia/desktop/RedHat9.0/qtopia-desktop-${PV}${REV}rh9.i386.rpm"
HOMEPAGE="http://www.trolltech.com/download/qtopia/"

DEPEND=""
RDEPEND="virtual/libc
	|| ( x11-libs/libX11 virtual/x11 )"

LICENSE="trolltech_PUL-1.0"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RESTRICT="nomirror nostrip"

src_install() {
	dodir ${QD}
	exeinto ${QD}/qtopiadesktop/bin ; doexe opt/Qtopia/qtopiadesktop/bin/assistant
	insinto ${QD}/qtopiadesktop/doc/en ; doins opt/Qtopia/qtopiadesktop/doc/en/*
	insinto ${QD}/qtopiadesktop/doc/de ; doins opt/Qtopia/qtopiadesktop/doc/de/*
	insinto ${QD}/qtopiadesktop/etc ; doins opt/Qtopia/qtopiadesktop/etc/*
	insinto ${QD}/qtopiadesktop/pics ; doins opt/Qtopia/qtopiadesktop/pics/*
	exeinto ${QD}/qtopiadesktop/plugins ; doexe opt/Qtopia/qtopiadesktop/plugins/*
	insinto ${QD}/lib ; doins opt/Qtopia/lib/*
	exeinto ${QD}/bin ; doexe opt/Qtopia/bin/qtopiadesktop
	newdoc /opt/Qtopia/qtopiadesktop/bin/README README.assistant
	newdoc opt/Qtopia/LICENSE.PERSONAL_USE LICENSE
	dodir /etc/env.d
	echo "PATH=${QD}/bin" > ${D}/etc/env.d/37qtopia-desktop-bin
	echo "LDPATH=${QD}/lib" >> ${D}/etc/env.d/37qtopia-desktop-bin
}

pkg_postinst() {
	elog " Finished installing Qtopia Desktop ${PV}${REV} into ${QD}"
	elog
	elog " To start Qtopia Desktop, run:"
	elog "   $ qtopiadesktop"
	elog
}
