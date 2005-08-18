# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vm-arm/vm-arm-1.0.2.ebuild,v 1.1 2005/08/18 04:26:28 vapier Exp $

inherit eutils rpm

# - Debian version is very old
# - Redhat/Fedora ones link against funky ssl
# - SuSe or MDK rpm's are the only ones that will really work
RPM_VER="70.suse9_2"
DESCRIPTION="highly optimized and accurate simulation of the ARM architecture"
HOMEPAGE="http://www.virtera.com/"
SRC_URI="vm-arm-se-${PV}-${RPM_VER}.i386.rpm"

LICENSE="VIRTERA"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch nostrip"

DEPEND="=dev-libs/openssl-0.9.7*
	=x11-libs/wxGTK-2.4*"

S=${WORKDIR}

pkg_setup() {
	if ! built_with_use x11-libs/wxGTK wxgtk1 ; then
		eerror "Please emerge x11-libs/wxGTK-2.4 with wxgtk1 in USE flags."
		die "GTK1 support in 11-libs/wxGTK-2.4 needed to run ${P}."
	fi
}

pkg_nofetch() {
	einfo "You need to perform the following steps to install this package:"
	einfo " - Sign up at ${HOMEPAGE}"
	einfo " - Check your email and visit the download location"
	einfo " - Download ${A} and place it in ${DISTDIR}"
	einfo " - emerge this package"
	einfo " - Put your license in ~/.virtera/"
}

src_install() {
	mv opt "${D}"/ || die
	dodir /opt/bin
	cd "${D}"
	for x in opt/virtera/vm-arm-se-${PV}/bin/i686/* ; do
		dosym /${x} /opt/bin/${x##*/}
	done
	find "${D}" -type d -exec chmod a+rx {} \;
}

pkg_postinst() {
	einfo "Please remember to put your license in ~/.virtera/"
}
