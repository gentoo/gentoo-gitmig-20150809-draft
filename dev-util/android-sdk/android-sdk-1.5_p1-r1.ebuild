# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/android-sdk/android-sdk-1.5_p1-r1.ebuild,v 1.1 2009/05/02 04:07:21 zmedico Exp $

EAPI="2"

MY_P="${PN}-linux_x86-${PV/_p/_r}"

DESCRIPTION="Open Handset Alliance's Android SDK/"
HOMEPAGE="http://code.google.com/android"
SRC_URI="http://dl.google.com/android/${MY_P}.zip"
RESTRICT="mirror"

LICENSE="android"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc examples"

DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jdk-1.5
	>=dev-java/ant-core-1.6.5
	amd64? ( app-emulation/emul-linux-x86-gtklibs )
	x86? ( x11-libs/gtk+:2 )"

src_install(){
	local destdir="/opt/${P/_p*/}"
	dodir "${destdir}"

	cd "${MY_P}"

	dodoc tools/NOTICE.txt RELEASE_NOTES.html || die
	rm -f tools/NOTICE.txt
	cp -pPR tools "${D}/${destdir}/" || die "failed to copy"
	mkdir -p "${D}/${destdir}/platforms" || die "failed to mkdir"
	local platform
	for platform in platforms/android-* ; do
		! use examples && rm -fr $platform/samples
		cp -pPR $platform "${D}/${destdir}/platforms" || die "failed to copy"
	done
	cp -pPR add-ons "${D}/${destdir}/" || die "failed to copy"
	use doc && dohtml -r docs documentation.html

	echo -n "PATH=\"${destdir}/tools" > "${T}/80android"
	echo ":${destdir}/platforms/android-${PV/_p*/}/tools\"" >> "${T}/80android"
	doenvd "${T}/80android"
}
