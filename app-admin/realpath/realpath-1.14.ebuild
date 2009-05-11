# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/realpath/realpath-1.14.ebuild,v 1.2 2009/05/11 20:29:15 loki_val Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="Return the canonicalized absolute pathname"
HOMEPAGE="http://packages.debian.org/unstable/utils/realpath"
SRC_URI="mirror://debian/pool/main/r/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="!sys-freebsd/freebsd-bin"
DEPEND="${RDEPEND}
	app-text/po4a"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	tc-export CC
	emake VERSION="${PV}"|| die "emake failed"
}

src_install() {
	emake VERSION="${PV}" DESTDIR="${D}" install || die "emake install failed"
	newdoc debian/changelog ChangeLog.debian
}
