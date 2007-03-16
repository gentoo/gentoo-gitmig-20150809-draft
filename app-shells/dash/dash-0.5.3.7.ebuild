# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/dash/dash-0.5.3.7.ebuild,v 1.2 2007/03/16 07:55:04 uberlord Exp $

inherit eutils versionator flag-o-matic toolchain-funcs

DEB_P="${PN}_$(replace_version_separator 3 '-')"
MY_P2="${DEB_P%-*}"
MY_P="${MY_P2/_/-}"

DESCRIPTION="Debian-version of NetBSD's lightweight bourne shell"
HOMEPAGE="http://ftp.debian.org/debian/pool/main/d/dash/"
SRC_URI="mirror://debian/pool/main/d/dash/${MY_P2}.orig.tar.gz \
	mirror://debian/pool/main/d/dash/${DEB_P}.diff.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="static"

DEPEND="dev-util/yacc"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}/${DEB_P}".diff

	# Below patch sorts the builtincmd structure correctly when LC_ALL isn't C
	epatch "${FILESDIR}/${MY_P}"-sort-locale.patch
}

src_compile() {
	use static && append-ldflags -static

	export CC="$(tc-getCC)"
	econf || die "econf failed"
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	exeinto /bin
	newexe src/dash dash
	newman src/dash.1 dash.1
	dodoc COPYING ChangeLog
}
