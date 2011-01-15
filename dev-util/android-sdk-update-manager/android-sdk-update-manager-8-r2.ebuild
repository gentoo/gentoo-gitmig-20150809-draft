# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/android-sdk-update-manager/android-sdk-update-manager-8-r2.ebuild,v 1.1 2011/01/15 13:10:54 rich0 Exp $

EAPI="3"

inherit eutils

MY_P="android-sdk_r0${PV}-linux_86"

DESCRIPTION="Open Handset Alliance's Android SDK"
HOMEPAGE="http://developer.android.com"
SRC_URI="http://dl.google.com/android/${MY_P}.tgz"
IUSE=""
RESTRICT="mirror"

LICENSE="android"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/tar
		app-arch/gzip"
RDEPEND=">=virtual/jdk-1.5
	>=dev-java/ant-core-1.6.5
	=dev-java/swt-3.5*
	amd64? ( app-emulation/emul-linux-x86-gtklibs )
	x86? ( x11-libs/gtk+:2 )"

ANDROID_SDK_DIR="/opt/${PN}"
QA_DT_HASH_x86="
	${ANDROID_SDK_DIR/\/}/tools/emulator
	${ANDROID_SDK_DIR/\/}/tools/adb
	${ANDROID_SDK_DIR/\/}/tools/mksdcard
	${ANDROID_SDK_DIR/\/}/tools/sqlite3
	${ANDROID_SDK_DIR/\/}/tools/hprof-conv
	${ANDROID_SDK_DIR/\/}/tools/zipalign
	${ANDROID_SDK_DIR/\/}/tools/dmtracedump
"
QA_DT_HASH_amd64="${QA_DT_HASH_x86}"

S="${WORKDIR}/android-sdk-linux_86"

pkg_setup() {
	enewgroup android || die
}

src_prepare(){
#	epatch "${FILESDIR}/${PN}-8-swt.patch"

	rm -rf tools/lib/x86*
}

src_install(){
	dodoc tools/NOTICE.txt "SDK Readme.txt" || die
	rm -f tools/NOTICE.txt "SDK Readme.txt"

	dodir "${ANDROID_SDK_DIR}/tools"
	cp -pPR tools/* "${ED}${ANDROID_SDK_DIR}/tools" || die "failed to install tools"

	# Maybe this is needed for the tools directory too.
	#keepdir "${ANDROID_SDK_DIR}"/{add-ons,docs,platforms,temp} || die "failed to keepdir"
	dodir "${ANDROID_SDK_DIR}"/{add-ons,docs,platforms,temp} || die "failed to dodir"

	fowners root:android "${ANDROID_SDK_DIR}"/{,add-ons,docs,platforms,temp} || die
	fperms 0775 "${ANDROID_SDK_DIR}"/{,add-ons,docs,platforms,temp} || die

	echo "PATH=\"${EPREFIX}${ANDROID_SDK_DIR}/tools:${EPREFIX}${ANDROID_SDK_DIR}/platform-tools\"" > "${T}/80${PN}" || die

	SWT_PATH="`dirname \`java-config -p swt-3.5\``"

	echo "ANDROID_SWT=\"${SWT_PATH}\"" >> "${T}/80${PN}" || die

	doenvd "${T}/80${PN}" || die

	echo "SEARCH_DIRS_MASK=\"${EPREFIX}${ANDROID_SDK_DIR}/\"" > "${T}/80${PN}" || die

	insinto "${EPREFIX}/etc/revdep-rebuild" && doins "${T}/80${PN}" || die

}

pkg_postinst() {
	elog "The Android SDK now uses its own manager for the development	environment."
	elog "You must be in the android group to manage the development environment."
	elog "Just run 'gpasswd -a <USER> android', then have <USER> re-login."
	elog "See http://developer.android.com/sdk/adding-components.html for more"
	elog "information."
	elog "If you have problems downloading the SDK, see http://code.google.com/p/android/issues/detail?id=4406"
}
