# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/android-sdk/android-sdk-1.0_p2.ebuild,v 1.2 2009/01/20 20:20:46 nelchael Exp $

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

	dodoc tools/NOTICE.txt RELEASE_NOTES.txt || die
	rm -f tools/NOTICE.txt
	cp -pPR tools android.jar "${D}/${destdir}/" || die "failed to copy"
	if use examples; then
		cp -pPR samples "${D}/${destdir}/" || die "failed to copy"
	fi
	use doc && dohtml -r docs documentation.html

	echo "PATH=\"${destdir}/tools\"" > "${T}/80android"
	doenvd "${T}/80android"
}
