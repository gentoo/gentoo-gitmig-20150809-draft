# Copyright 2006-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/pftop/pftop-0.7.ebuild,v 1.1 2009/01/27 12:50:32 the_paya Exp $

inherit bsdmk flag-o-matic
DESCRIPTION="Pftop: curses-based utility for real-time display of active states and rule statistics for pf"

HOMEPAGE="http://www.eee.metu.edu.tr/~canacar/pftop/"

SRC_URI="http://www.eee.metu.edu.tr/~canacar/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86-fbsd"
IUSE=""

RDEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-0.7-pcap.patch"
	epatch "${FILESDIR}/${PN}-0.7-dead.patch"
	epatch "${FILESDIR}/${PN}-0.7-pr123670.patch"
	epatch "${FILESDIR}/${PN}-0.7-queue.patch.bz2"
	epatch "${FILESDIR}/${PN}-0.7-strnvis_fix.patch"
}

src_compile() {
	# OS_LEVEL variable refers to the version of pf shipped with OpenBSD.
	# On FreeBSD we have to know it.
	local OSLEVEL

	case ${CHOST} in
		*-openbsd*)
			local obsdver=${CHOST/*-openbsd/}
			OSLEVEL=${obsdver//.}
			;;
		*-freebsd5.[34])	OSLEVEL=35 ;;
		*-freebsd6.[012])	OSLEVEL=37 ;;
		*-freebsd*)		OSLEVEL=41 ;;
		*)
			die "Your OS/Version is not supported (${CHOST}), please report."
			;;
	esac
	append-flags "-DHAVE_SNPRINTF -DHAVE_VSNPRINTF -DOS_LEVEL=${OSLEVEL}"
	mkmake LOCALBASE="/usr" CFLAGS="${CFLAGS}" || die "pmake failed"
}

src_install() {
	mkinstall DESTDIR="${D}" LOCALBASE="/usr" MANDIR="/usr/share/man/man" install || die
}
