# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/dash/dash-0.5.2.1.ebuild,v 1.3 2005/03/30 16:11:49 hansmi Exp $

inherit eutils versionator flag-o-matic toolchain-funcs

DEB_P="${PN}_$(replace_version_separator 3 '-')"
MY_P2="${DEB_P%-*}"
MY_P="${MY_P2/_/-}"

DESCRIPTION="Debian-version of NetBSD's lightweight bourne shell"
HOMEPAGE="http://ftp.debian.org/debian/pool/main/d/dash/"
SRC_URI="mirror://debian/pool/main/d/dash/${MY_P2}.orig.tar.gz \
	mirror://debian/pool/main/d/dash/${DEB_P}.diff.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ppc"
IUSE="diet static"

RDEPEND="diet? ( dev-libs/dietlibc )
	!diet? ( virtual/libc )"
DEPEND="${RDEPEND}
	sys-apps/sed
	dev-util/yacc"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${DEB_P}.diff
}

src_compile() {
	use static && append-ldflags -static

	CC="$(tc-getCC)"
	use diet && CC="diet ${CC}"

	econf CC="${CC}" || die "econf failed"
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	exeinto /bin
	newexe src/dash dash
	newman src/dash.1 dash.1
	dodoc COPYING ChangeLog
}
