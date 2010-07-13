# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/android-sdk-update-manager/android-sdk-update-manager-3.ebuild,v 1.2 2010/07/13 07:24:31 nelchael Exp $

EAPI="2"

inherit versionator eutils

MY_PN="android-sdk"
MY_P="${MY_PN}_r${PV}-linux"

DESCRIPTION="Open Handset Alliance's Android SDK"
HOMEPAGE="http://developer.android.com"
SRC_URI="http://dl.google.com/android/${MY_P}.tgz"
IUSE=""
RESTRICT="mirror"

LICENSE="android"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="app-arch/tar
		app-arch/gzip"
RDEPEND=">=virtual/jdk-1.5
	>=dev-java/ant-core-1.6.5
	amd64? ( app-emulation/emul-linux-x86-gtklibs )
	x86? ( x11-libs/gtk+:2 )"

pkg_preinst() {
	enewgroup android
}

src_install(){
	local destdir="/opt/${P/_p*/}"
	dodir "${destdir}"

	cd "android-sdk-linux"

	dodoc tools/NOTICE.txt "SDK Readme.txt" || die
	rm -f tools/NOTICE.txt "SDK Readme.txt"
	cp -pPR tools "${D}/${destdir}/" || die "failed to copy"
	mkdir -p "${D}/${destdir}/"{platforms,add-ons,docs,temp} || die "failed to mkdir"
	# Maybe this is needed for the tools directory too.
	chgrp android "${D}/${destdir}/"{platforms,add-ons,docs,temp}
	chmod 775 "${D}/${destdir}/"{platforms,add-ons,docs,temp}

	echo -n "PATH=\"${destdir}/tools" > "${T}/80android"
	echo ":${destdir}/platforms/android-${PV/_p*/}/tools\"" >> "${T}/80android"
	doenvd "${T}/80android"
}

pkg_postinst() {
	ewarn "The Android SDK now uses its own manager for the development	environment."
	ewarn "You must be in the android group to manage the development environment."
	ewarn "Just run 'gpasswd -a <USER> android', then have <USER> re-login."
	ewarn "See http://developer.android.com/sdk/adding-components.html for more"
	ewarn "information."
}
