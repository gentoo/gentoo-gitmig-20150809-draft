# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxserver-freenx/nxserver-freenx-0.5.0-r2.ebuild,v 1.2 2007/04/02 09:47:31 voyageur Exp $

inherit multilib eutils rpm

DESCRIPTION="An X11/RDP/VNC proxy server especially well suited to low bandwidth links such as wireless, WANS, and worse"
HOMEPAGE="http://freenx.berlios.de/"
SRC_URI="ftp://ftp.pbone.net/mirror/download.fedora.redhat.com/pub/fedora/linux/extras/5/i386/freenx-0.5.0-5.fc5.i386.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="strip"
IUSE="arts cups esd nxclient"
DEPEND="virtual/ssh
	dev-tcltk/expect
	sys-apps/gawk
	net-analyzer/gnu-netcat
	x86? ( nxclient? ( =net-misc/nxclient-1.5* )
	      !nxclient? ( !net-misc/nxclient ) )
	amd64? ( nxclient? ( =net-misc/nxclient-1.5* )
	        !nxclient? ( !net-misc/nxclient ) )
	!x86? ( !amd64? ( !net-misc/nxclient ) )
	=net-misc/nx-1.5*
	arts? ( kde-base/arts )
	cups? ( net-print/cups )
	esd? ( media-sound/esound )
	!net-misc/nxserver-freeedition"

RDEPEND="${DEPEND}"

S=${WORKDIR}

export NX_HOME_DIR=/var/lib/nxserver/home

pkg_setup () {
	enewuser nx -1 -1 ${NX_HOME_DIR}
}

src_unpack() {
	rpm_unpack ${DISTDIR}/${A}
	cd ${S}

	# fix the start commands
	epatch ${FILESDIR}/freenx-0.5.0-startup.patch
	# fix fullscreen support; see bug 150200
	epatch ${FILESDIR}/freenx-0.5.0-fullscreen.patch
	# fix newer clients support; bug 155063
	epatch ${FILESDIR}/freenx-0.5.0-backingstore.patch

	mv etc/nxserver/node.conf.sample etc/nxserver/node.conf || die

	sed -e 's|^PATH_LIB=.*$|PATH_LIB=$NX_DIR/lib/NX/lib|;' -i usr/bin/nxloadconfig || die

	# Change the defaults in nxloadconfig to meet the users needs.
	if use arts ; then
		einfo "Enabling arts support."
		sed -i '/ENABLE_ARTSD_PRELOAD=/s/"0"/"1"/' usr/bin/nxloadconfig || die
		sed -i '/ENABLE_ARTSD_PRELOAD=/s/"0"/"1"/' etc/nxserver/node.conf || die
	fi
	if use esd ; then
		einfo "Enabling esd support."
		sed -i '/ENABLE_ESD_PRELOAD=/s/"0"/"1"/' usr/bin/nxloadconfig || die
		sed -i '/ENABLE_ESD_PRELOAD=/s/"0"/"1"/' etc/nxserver/node.conf || die
	fi
	if use cups ; then
		einfo "Enabling cups support."
		sed -i '/ENABLE_KDE_CUPS=/s/"0"/"1"/' usr/bin/nxloadconfig || die
		sed -i '/ENABLE_KDE_CUPS=/s/"0"/"1"/' etc/nxserver/node.conf || die
	fi
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	NX_ETC_DIR=/etc/nxserver
	NX_SESS_DIR=/var/lib/nxserver/db

	dobin usr/bin/nxserver
	dobin usr/bin/nxnode
	dobin usr/bin/nxnode-login
	dobin usr/bin/nxkeygen
	dobin usr/bin/nxloadconfig
	dobin usr/bin/nxsetup
	( ( use x86 || use amd64 ) && use nxclient ) || dobin usr/bin/nxprint
	( ( use x86 || use amd64 ) && use nxclient ) || dobin usr/bin/nxclient

	dodir ${NX_ETC_DIR}
	for x in passwords passwords.orig ; do
		touch ${D}${NX_ETC_DIR}/$x
		chmod 600 ${D}${NX_ETC_DIR}/$x
	done

	insinto ${NX_ETC_DIR}
	doins etc/nxserver/node.conf

	dodir ${NX_HOME_DIR}

	for x in closed running failed ; do
		keepdir ${NX_SESS_DIR}/$x
		fperms 0700 ${NX_SESS_DIR}/$x
	done
}

pkg_postinst () {
	usermod -s /usr/bin/nxserver nx || die "Unable to set login shell of nx user!!"
	usermod -d ${NX_HOME_DIR} nx || die "Unable to set home directory of nx user!!"

	elog "Run nxsetup --override --install to complete the installation"
}
