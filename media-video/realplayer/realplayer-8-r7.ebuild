# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/realplayer/realplayer-8-r7.ebuild,v 1.2 2004/01/16 10:48:24 liquidx Exp $

inherit nsplugins

RESTRICT="nostrip fetch"

DESCRIPTION="RealPlayer 8 is a streaming media player"
HOMEPAGE="http://forms.real.com/real/player/unix/unix.html"

SRC_URI="x86? ( rp8_linux20_libc6_i386_cs2.bin )
	ppc? ( rp8_linux_powerpc_cs1.bin )
	sparc? ( rp8_linux_sparc_cs1.bin )
	alpha? ( rp8_linux_alpha_rh62_cs1.bin )"

LICENSE="realplayer8"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
IUSE="kde gnome"

# Fix for bug 15314
DEPEND="virtual/glibc
	sparc? ( sys-libs/lib-compat )"
RDEPEND="virtual/x11"
PDEPEND="x86? ( >=media-plugins/realvideo-codecs-9 )"

BASE="/opt/RealPlayer8"
S=${WORKDIR}

pkg_nofetch() {
	use x86 && REAL_OS="Linux 2.x (libc6 i386)"
	use ppc && REAL_OS="Linux/PPC 2000"
	use alpha && REAL_OS="Linux/Alpha (Red Hat 6.2)"
	use sparc && REAL_OS="Linux/Sparc (Red Hat 6.2)"

	einfo "Please go to ${HOMEPAGE}"
	einfo "and download the appropriate realplayer binary installer"
	einfo "for OS type : ${REAL_OS}"
	einfo " "
	einfo "Download ${A} and place it in :"
	einfo "${DISTDIR}"
	einfo " "
	use x86 && \
		ewarn "Please note, do NOT download the rpm, just the .bin file"
}

src_unpack() {
	use x86 && BYTECOUNT=4799691
	use ppc && BYTECOUNT=7260910
	use alpha && BYTECOUNT=7130860
	use sparc && BYTECOUNT=6375000
	tail -c ${BYTECOUNT} ${DISTDIR}/${A} | tar xz 2> /dev/null
}

src_compile() {
	return
}

src_install () {
	insinto ${BASE}/Codecs
	doins Codecs/*
	insinto ${BASE}/Common
	doins Common/*
	insinto ${BASE}/Plugins/ExtResources
	doins Plugins/ExtResources/*
	insinto ${BASE}/Plugins
	doins Plugins/*.so.6.0
	insinto ${BASE}
	doins *.xpm *.png *.rm rpnp.so LICENSE README ${FILESDIR}/mimeinfo
	exeinto ${BASE}
	doexe realplay
	dodir /opt/bin
	dosym ${BASE}/realplay /opt/bin

	# NS plugin
	for b in /opt/netscape /usr/lib/mozilla /usr/lib/nsbrowser
	do
		if [ -d ${b} ] ; then
			dodir ${b}/plugins
			dosym ${BASE}/rpnp.so ${b}/plugins
		fi
	done

	# Desktop menu entry ; KDE, Gnome
	if use kde ; then
		insinto /usr/share/applnk/Multimedia
		doins ${FILESDIR}/realplayer.desktop
	fi
	if use gnome ; then
		insinto /usr/share/applications
		doins ${FILESDIR}/realplayer.desktop
	fi

	cp rp7.xpm realplayer8.xpm
	insinto /usr/share/pixmaps
	doins realplayer8.xpm

	# Mimetypes - Intentionally left blank (for now)
	# Better not use the provided scripts from Real, they are outdated
	# See ${BASE}/mimeinfo for the correct mimetypes if you need them
}

pkg_postinst() {
	echo
	einfo "Finished installing RealPlayer8 into ${BASE}"
	einfo "You can start the player by running 'realplay'"
	einfo "You have to agree to the terms in ${BASE}/LICENSE or unmerge"
	echo
}
