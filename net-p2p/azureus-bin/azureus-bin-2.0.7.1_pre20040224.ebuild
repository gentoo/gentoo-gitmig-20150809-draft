# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/azureus-bin/azureus-bin-2.0.7.1_pre20040224.ebuild,v 1.3 2004/03/24 04:21:30 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Azureus - Java BitTorrent Client"
HOMEPAGE="http://azureus.sourceforge.net/"

MY_PN=${PN/-bin/}
MY_PV=`echo ${PV} | sed 's/_pre.*$//'`
MY_DT=`echo ${PV} | sed 's/^.*_pre//'`
MY_JV="${MY_PV}-${MY_DT}"

# The release version we're starting from
BASE_V="2.0.7.0a"

S=${WORKDIR}/${MY_PN}

SRC_URI="mirror://sourceforge/${MY_PN}/Azureus_${BASE_V}_linux.GTK.tar.bz2
	 mirror://sourceforge/${MY_PN}/Azureus_${BASE_V}_linux.Motif.tar.bz2
	 mirror://gentoo/seda-${MY_DT}.zip
	 mirror://gentoo/Azureus2-${MY_JV}.jar"

RESTRICT="nomirror"

LICENSE="GPL-2 BSD"
SLOT="0"

KEYWORDS="~x86"
IUSE="gtk kde"

DEPEND="kde? ( >=x11-libs/qt-3*
		>=kde-base/kdelibs-3* )"

RDEPEND="${DEPEND}
	dev-java/commons-cli
	gtk? ( =x11-libs/gtk+-2* )
	>=virtual/jre-1.4"

# Where to install the package
PROGRAM_DIR="/usr/lib/${MY_PN}"

src_unpack() {
	if [ `use gtk` ] ; then
		unpack Azureus_${BASE_V}_linux.GTK.tar.bz2
		echo
		einfo "Using the GTK Azureus package, to use the Motif package"
		einfo "  set USE=\"-gtk\" in /etc/make.conf."
		echo
	else
		unpack Azureus_${BASE_V}_linux.Motif.tar.bz2
		echo
		einfo "Using the Motif Azureus package, to use the GTK package"
		einfo "  set USE=\"gtk\" in /etc/make.conf."
		echo

		# Delete these links so they don't mess us up in install
		# Links are remade later in the installation
		rm ${S}/libXm.so
		rm ${S}/libXm.so.2
	fi

	cp ${DISTDIR}/Azureus2-${MY_JV}.jar ${S}/Azureus2.jar

	# Patch cleans up Makefile
	epatch ${FILESDIR}/${PN}-Makefile.patch

	cp ${FILESDIR}/${P}-gentoo.sh ${S}/azureus

	if [ ! `use kde` ] ; then
		sed -i "s:ON=TRUE:ON=FALSE:" ${MY_PN}/azureus
	fi

	# Set runtime settings in the startup script
	sed -i "s:##PROGRAM_DIR##:${PROGRAM_DIR}:" ${MY_PN}/azureus

	# Unpack seda
	cd ${S}
	unpack seda-${MY_DT}.zip
	tar xjf seda-jnilibs-linux.tar.bz2
	rm seda*bz2
}

src_compile() {
	if [ `use kde` ] ; then
		cd ${S}/systray4jdaemon
		emake || die
	fi
}

src_install() {
	cd ${S}

	insinto ${PROGRAM_DIR}
	exeinto ${PROGRAM_DIR}

	doins *.jar id.azureus.dir.file
	doexe *.so

	# This only needs to be run when using the Motif package
	if [ ! `use gtk` ] ; then
		doexe libXm.so.2.1
		dosym libXm.so.2.1 ${PROGRAM_DIR}/libXm.so
		dosym libXm.so.2.1 ${PROGRAM_DIR}/libXm.so.2
	fi

	if [ `use kde` ] ; then
		doexe systray4jdaemon/systray4jd
	fi

	dobin azureus

	dodoc README.linux seda-README.txt
}

pkg_postinst() {
	echo
	einfo "Due to the nature of the portage system, we recommend"
	einfo "that users check portage for new versions of Azureus"
	einfo "instead of attempting to use the auto-update feature."
	echo
	einfo "After running azureus for the first time, configuration"
	einfo "options will be placed in ~/.azureus/gentoo.config"
	einfo "It is recommended that you modify this file rather than"
	einfo "the azureus startup script directly."
	echo

	if [ `use kde` ] ; then
		einfo "The KDE system tray daemon has been built with your"
		einfo "installation.  To disable this feature you must modify"
		einfo "~/.azureus/gentoo.config after running azureus for the"
		einfo "first time."
		echo
	fi

	einfo "Currently, only the swt interface is usable.  Please comment"
	einfo "at http://bugs.gentoo.org/show_bug.cgi?id=35556 if you have a"
	einfo "fix for the other interfaces."
}
