# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/aim/aim-1.5.286.ebuild,v 1.2 2003/12/14 12:32:05 spyderous Exp $

IUSE=""
DESCRIPTION="AOL's Instant Messenger client"
SRC_URI="${P}.tgz"
HOMEPAGE="http://www.aim.com/get_aim/linux/latest_linux.adp"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
RESTRICT="nostrip fetch"
DEPEND="=x11-libs/gtk+-1.2*
		>=dev-libs/glib-1.2
		virtual/x11"
S="${WORKDIR}"

pkg_nofetch() {
	einfo "Please go to"
	einfo "http://www.aim.com/get_aim/linux/latest_linux.adp"
	einfo "and place ${A} in ${DISTDIR}."
}

src_install() {

	# Initial install
	dodir /opt/${PN}
	cd ${S}/usr
	cp -dR * ${D}/opt/${PN}/

	# Set up paths for env
	echo "LDPATH=/opt/${PN}/lib" > ${T}/99aim
	echo "PATH=/opt/${PN}" >> ${T}/99aim
	insinto /etc/env.d
	doins ${T}/99aim

	# Needed shell script
	echo "#!/bin/bash" > ${T}/aim
	echo "/opt/aim/bin/aim --install_dir /opt/aim/lib/aim" >> ${T}/aim
	exeinto /opt/aim
	doexe ${T}/aim

	prepall
}
