# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/ponyprog/ponyprog-2.07a.ebuild,v 1.7 2009/11/24 09:31:41 flameeyes Exp $

inherit eutils

DESCRIPTION="Serial device programmer"
HOMEPAGE="http://www.lancos.com/ppwin95.html"
SRC_URI="mirror://sourceforge/${PN}/PonyProg2000-${PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="epiphany firefox seamonkey"

RDEPEND="x11-libs/libXaw
	x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libXext
	x11-libs/libX11
	epiphany? ( www-client/epiphany )
	firefox? ( || ( www-client/mozilla-firefox www-client/mozilla-firefox-bin ) )
	seamonkey? ( || ( www-client/seamonkey www-client/seamonkey-bin ) )"
DEPEND="${RDEPEND}
	media-gfx/imagemagick"

S="${WORKDIR}/PonyProg2000-${PV}"

pkg_setup() {
	if (use epiphany && use firefox) || (use epiphany && use seamonkey) || (use firefox && use seamonkey) ; then
		die "Only one of epiphany, firefox or seamonkey can be in USE."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s:\$(HOME)/Progetti/PonyProg_Sourceforge/v:${S}/v:" \
		-e 's/\-O2//' \
		v/Config.mk || die "sed failed"

	sed -i -e 's/<asm\/io.h>/<sys\/io.h>/' *.cpp || die "sed failed"

	if use epiphany ; then
		sed -i -e 's/netscape/epiphany/' e2cmdw.cpp
	fi
	if use firefox ; then
		sed -i -e 's/netscape/firefox/' e2cmdw.cpp
	fi
	if use seamonkey ; then
		sed -i -e 's/netscape/seamonkey/' e2cmdw.cpp
	fi
	convert ponyprog.ico ponyprog.png

	# Fix compilation with gcc-4.3, bug #227503
	epatch "${FILESDIR}/${P}-gcc43.patch"
}

src_compile() {
	# bug #282244
	emake -j1 || die "emake failed"
}

src_install() {
	dobin bin/ponyprog2000 || die
	keepdir /var/lock/uucp
	fowners uucp:uucp /var/lock/uucp
	fperms 755 /var/lock/uucp
	doicon ponyprog.png
	make_desktop_entry ponyprog2000 PonyProg2000 ponyprog
}

pkg_postinst() {
	elog "To use the COM port in user mode (not as root), you need to"
	elog "be in the 'uucp' group."
	elog
	elog "To use the LPT port in user mode (not as root) you need a kernel with"
	elog "ppdev, parport and parport_pc compiled in or as modules. You need the"
	elog "rights to write to /dev/parport? devices."
}
