# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mmv/mmv-1.01b_p14.ebuild,v 1.5 2011/01/05 16:19:01 jlec Exp $

inherit eutils toolchain-funcs

DEB_PATCH_VER=${PV#*_p}
MY_VER=${PV%_p*}

DESCRIPTION="Move/copy/append/link multiple files according to a set of wildcard patterns."
HOMEPAGE="http://packages.debian.org/unstable/utils/mmv"
SRC_URI="
	mirror://debian/pool/main/m/mmv/${PN}_${MY_VER}.orig.tar.gz
	mirror://debian/pool/main/m/mmv/${PN}_${MY_VER}-${DEB_PATCH_VER}.diff.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

S=${WORKDIR}/${PN}-${MY_VER}.orig

src_unpack() {
	unpack ${PN}_${MY_VER}.orig.tar.gz
	epatch "${DISTDIR}"/${PN}_${MY_VER}-${DEB_PATCH_VER}.diff.gz
}

src_compile() {
	mmv_CFLAGS=" -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
	emake CC="$(tc-getCC)" CFLAGS="${mmv_CFLAGS} ${CFLAGS}" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dobin mmv || die
	dosym mmv /usr/bin/mcp || die
	dosym mmv /usr/bin/mln || die
	dosym mmv /usr/bin/mad || die

	doman mmv.1 || die
	newman mmv.1 mcp.1 || die
	newman mmv.1 mln.1 || die
	newman mmv.1 mad.1 || die

	dodoc ANNOUNCE debian/{changelog,control} || die
}
