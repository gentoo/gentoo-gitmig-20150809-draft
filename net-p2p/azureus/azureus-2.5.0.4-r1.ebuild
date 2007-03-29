# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/azureus/azureus-2.5.0.4-r1.ebuild,v 1.1 2007/03/29 18:04:31 wltjr Exp $

inherit eutils fdo-mime java-pkg-2 java-ant-2

DESCRIPTION="Azureus - Java BitTorrent Client"
HOMEPAGE="http://azureus.sourceforge.net/"
SRC_URI="mirror://sourceforge/azureus/azureus_${PV}_source.zip"
LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"

IUSE="source"

# >=swt-3.2 for bug
# https://bugs.gentoo.org/show_bug.cgi?id=135835

RDEPEND="
	>=virtual/jre-1.5
	>=dev-java/swt-3.2-r1
	>=dev-java/log4j-1.2.8
	>=dev-java/commons-cli-1.0
	>=dev-java/bcprov-1.35
	!net-p2p/azureus-bin"
DEPEND="${RDEPEND}
	>=virtual/jdk-1.5
	dev-util/desktop-file-utils
	>=dev-java/ant-core-1.6.2
	|| ( =dev-java/eclipse-ecj-3.2* =dev-java/eclipse-ecj-3.1* )
	source? ( app-arch/zip )
	>=app-arch/unzip-5.0"

S=${WORKDIR}/${PN}

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}

	# patches from 2.5.0.0 still work here
	EPATCH_SUFFIX="patch" EPATCH_FORCE="yes" \
		epatch ${FILESDIR}/fedora-${PV}/

	#removing osx files and entries
	rm -fr org/gudy/azureus2/ui/swt/osx org/gudy/azureus2/platform/macosx
	#removing windows files
	rm -fr org/gudy/azureus2/ui/swt/win32 org/gudy/azureus2/platform/win32
	#removing test files
	rm -fr org/gudy/azureus2/ui/swt/test
	rm -f org/gudy/azureus2/ui/console/multiuser/TestUserManager.java
	#removing bouncycastle
	rm -fr org/bouncycastle

	mkdir -p build/libs
	cd build/libs
	java-pkg_jar-from log4j
	java-pkg_jar-from commons-cli-1
	java-pkg_jar-from swt-3
	java-pkg_jar-from bcprov
}

src_compile() {
	# javac likes to run out of memory during build... use ecj instead
	java-pkg_force-compiler ecj-3.2 ecj-3.1

	eant ${ant_extra_opts} jar
}

src_install() {
	java-pkg_dojar dist/Azureus2.jar || die "dojar failed"


	java-pkg_dolauncher ${PN} \
		--main org.gudy.azureus2.ui.common.Main \
		-pre ${FILESDIR}/${PN}-2.5.0.0-pre \
		--pkg_args '--ui=${UI}' \
		--java_args '-Dazureus.install.path=${HOME}/.azureus/ ${JAVA_OPTIONS}'

	doicon "${FILESDIR}/azureus.png"
	domenu "${FILESDIR}/azureus.desktop"
	use source && java-pkg_dosrc ${S}/{com,org}
}

pkg_postinst() {
	echo
	elog "Due to the nature of the portage system, we recommend"
	elog "that users check portage for new versions of Azureus"
	elog "instead of attempting to use the auto-update feature."
	elog "We also set azureus.install.path to ~/.azureus so auto"
	elog "update probably does not even work."
	elog ""
	elog "You can disable auto-update in"
	elog "Tools->Options...->Interface->Start"
	echo
	elog "After running azureus for the first time, configuration"
	elog "options will be placed in ~/.azureus/gentoo.config"
	elog "It is recommended that you modify this file rather than"
	elog "the azureus startup script directly."
	echo
	elog "As of this version, the new ui type 'console' is supported,"
	elog "and this may be set in ~/.azureus/gentoo.config."
	echo
	elog "If you have problems starting azureus, try starting it"
	elog "from the command line to look at debugging output."
	echo
	ewarn "If you are upgrading, and the menu in azureus has entries like"
	ewarn "\"!MainWindow.menu.transfers!\" then you have a stray"
	ewarn "MessageBundle.properties file,"
	ewarn "and you may safely delete ~/.azureus/MessagesBundle.properties"
	echo
	elog "It's recommended to use Sun's Java version 1.5 or later."
	elog "If you're experiencing problems running azureus and you've"
	elog "using an older version of Java, try to upgrading to a new version. "
	echo
	elog "New in 2.5.0.0-r3:"
	ewarn 'azureus.install.path was changed to ${HOME}/.azureus/. Before'
	ewarn 'the Azureus plugin dir was created to the current working directory.'
	ewarn 'This means that you probably have a useless plugins directory in'
	ewarn 'your home directory.'
	ewarn 'See http://bugs.gentoo.org/show_bug.cgi?id=145908'
	ewarn 'for more information. Also you probably need to move the user'
	ewarn 'installed plugins to the new plugin directory.'
	echo
	ewarn "Please, do not run azureus as root!"
	ewarn "Azureus has not been developed for multi-user environments!"

	fdo-mime_desktop_database_update
}

pkg_prerm() {
	fdo-mime_desktop_database_update
}
