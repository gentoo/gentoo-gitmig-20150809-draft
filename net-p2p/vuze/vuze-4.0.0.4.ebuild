# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/vuze/vuze-4.0.0.4.ebuild,v 1.2 2009/02/06 12:06:46 caster Exp $

EAPI=2

JAVA_PKG_IUSE="source"

inherit eutils fdo-mime java-pkg-2 java-ant-2

MAIN_DIST=Vuze_${PV}_source.zip
PLUGINS_N=azplugins
RATING_N=azrating
UPDATER_N=azupdater
UPNPAV_N=azupnpav
PLUGINS_V=2.1.6
RATING_V=1.3.1
UPDATER_V=1.8.8
UPNPAV_V=0.2.2
PLUGINS_DIST=${PLUGINS_N}_${PLUGINS_V}.jar
RATING_DIST=${RATING_N}_${RATING_V}.jar
UPDATER_DIST=${UPDATER_N}_${UPDATER_V}.zip
UPNPAV_DIST=${UPNPAV_N}_${UPNPAV_V}.zip

ALLPLUGINS_URL="http://azureus.sourceforge.net/plugins"

DESCRIPTION="BitTorrent client in Java, formerly called Azureus"
HOMEPAGE="http://www.vuze.com/"
SRC_URI="mirror://sourceforge/azureus/${MAIN_DIST}
	${ALLPLUGINS_URL}/${PLUGINS_DIST}
	${ALLPLUGINS_URL}/${RATING_DIST}
	${ALLPLUGINS_URL}/${UPDATER_DIST}
	${ALLPLUGINS_URL}/${UPNPAV_DIST}"
LICENSE="GPL-2 BSD"

SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 x86"
IUSE=""

# bundles parts of commons-lang, but modified
# bundles parts of http://www.programmers-friend.org/
RDEPEND="
	dev-java/json-simple:0
	>=dev-java/bcprov-1.35:0
	>=dev-java/commons-cli-1.0:1
	>=dev-java/log4j-1.2.8:0
	>=dev-java/swt-3.4:3.4[cairo,xulrunner]
	!net-p2p/azureus-bin
	>=virtual/jre-1.5"

DEPEND="${RDEPEND}
	app-arch/unzip
	dev-util/desktop-file-utils
	>=virtual/jdk-1.5"

JAVA_PKG_FILTER_COMPILER="jikes"

src_unpack() {
	mkdir "${S}" && cd "${S}" || die
	unpack ${MAIN_DIST}

	cd "${WORKDIR}"
	mkdir -p plugins/{${PLUGINS_N},${RATING_N},${UPDATER_N},${UPNPAV_N}} || die
	cp "${DISTDIR}/${PLUGINS_DIST}" plugins/${PLUGINS_N} || die
	cp "${DISTDIR}/${RATING_DIST}" plugins/${RATING_N} || die
	cd "${WORKDIR}/plugins/${UPDATER_N}" && unpack ${UPDATER_DIST} || die
	cd "${WORKDIR}/plugins/${UPNPAV_N}" && unpack ${UPNPAV_DIST} || die

	cd "${S}"
	epatch "${FILESDIR}/patches-4.0.0.4/use-jdk-cipher-only.diff"
	epatch "${FILESDIR}/patches-4.0.0.4/remove-osx-platform.diff"

	### Removes OS X files and entries.
	rm -rv "org/gudy/azureus2/platform/macosx" \
		   "org/gudy/azureus2/ui/swt/osx" || die

	### Removes Windows files.
	rm -v ./org/gudy/azureus2/ui/swt/win32/Win32UIEnhancer.java || die

	### Removes test files.
	rm -rv "org/gudy/azureus2/ui/swt/test" \
		org/gudy/azureus2/ui/console/multiuser/TestUserManager.java || die

	### Removes bouncycastle (we use our own bcprov).
	rm -rv "org/bouncycastle" || die

	### Removes bundled json
	rm -rv "org/json" || die

	mkdir -p build/libs || die
}

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="swt-3.4,bcprov,json-simple,log4j,commons-cli-1"

src_compile() {
	local mem
	use amd64 && mem="256"
	use x86   && mem="192"
	use ppc   && mem="192"
	use ppc64 && mem="256"
	export ANT_OPTS="-Xmx${mem}m"
	java-pkg-2_src_compile
}

src_install() {
	java-pkg_dojar dist/*.jar || die "dojar failed"
	dodoc ChangeLog.txt || die

	java-pkg_dolauncher "${PN}" \
		--main org.gudy.azureus2.ui.common.Main -pre "${FILESDIR}/${PN}-4.1.0.0-pre" \
		--java_args '-Dazureus.install.path=/usr/share/vuze/ ${JAVA_OPTIONS}' \
		--pkg_args '--ui=${UI}'
	dosym vuze /usr/bin/azureus

	insinto /usr/share/${PN}/
	doins -r "${WORKDIR}/plugins"

	# https://bugs.gentoo.org/show_bug.cgi?id=204132
	java-pkg_register-environment-variable MOZ_PLUGIN_PATH /usr/lib/nsbrowser/plugins

	doicon "${FILESDIR}/${PN}.png"
	domenu "${FILESDIR}/${PN}.desktop"

	use source && java-pkg_dosrc "${S}"/{com,edu,org}
}

pkg_postinst() {
	###
	### @Todo We should probably deactivate auto-update it by default,
	###       or even remove the option - bug #218959
	###
	ewarn "Running Vuze as root is not supported and may result in untracked"
	ewarn "updates to shared components and then collisions on updates via portage"

	elog "Vuze has been formerly called Azureus and many references to the old name remain."
	elog
	elog "Since version 4.0.0.2, plugins that are normally bundled by upstream"
	elog "(and auto-installed in each user's ~/.azureus if not bundled)"
	elog "are now installed into shared plugin directory by the ebuild."
	elog "Users are recommended to delete the following plugin copies:"
	elog "~/.azureus/plugins/{${PLUGINS_N},${RATING_N},${UPDATER_N},${UPNPAV_N}}"
	elog
	elog "Vuze may warn that shared plugin dir is not writable, that's fine."
	elog "It may also attempt to update some these plugins and fail to write."
	elog "In that case look for or fill a bump bug in bugs.gentoo.org"
	elog
	elog "We plan to disable updater for shared components and plugins."
	elog "See progress in bug #218959, patches welcome."
	elog
	elog "After running Vuze for the first time, configuration"
	elog "options will be placed in '~/.azureus/gentoo.config'."
	elog "If you need to change some startup options, you should"
	elog "modify this file, rather than the startup script."
	elog "Using this config file you can start the console UI."
	elog
	elog "To switch from classic UI to Vuze use"
	elog "1: Tools > Options > Interface > Start > Display Vuze UI Chooser"
	elog "2: Toolbar (right-hand side)"
	elog
	elog "If you have problems starting Vuze, try starting it"
	elog "from the command line to look at debugging output."

	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
