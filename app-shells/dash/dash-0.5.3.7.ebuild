# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/dash/dash-0.5.3.7.ebuild,v 1.3 2007/03/16 10:17:28 uberlord Exp $

inherit eutils flag-o-matic toolchain-funcs

DEB_PV=${PV%.*}
DEB_PATCH=${PV##*.}
DEB_PF="${PN}_${DEB_PV}-${DEB_PATCH}"
MY_P="${PN}-${DEB_PV}"

DESCRIPTION="Debian-version of NetBSD's lightweight bourne shell"
HOMEPAGE="http://ftp.debian.org/debian/pool/main/d/dash/"
SRC_URI="mirror://debian/pool/main/d/dash/${PN}_${DEB_PV}.orig.tar.gz \
	mirror://debian/pool/main/d/dash/${DEB_PF}.diff.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="static"

DEPEND=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}/${DEB_PF}".diff

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
