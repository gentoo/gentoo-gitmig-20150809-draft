# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/gauche-cdb/gauche-cdb-0.3.1.ebuild,v 1.13 2012/07/07 14:34:32 hattya Exp $

EAPI="4"

inherit autotools eutils

MY_P="${P/g/G}"

DESCRIPTION="CDB binding for Gauche"
HOMEPAGE="http://sourceforge.jp/projects/gauche/"
SRC_URI="mirror://sourceforge.jp/gauche/8407/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="ia64 x86"
IUSE=""

RDEPEND="dev-scheme/gauche
	dev-db/tinycdb"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gpd.diff
	epatch "${FILESDIR}"/${P}-segv.diff
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README

	insinto "$(gauche-config --sitelibdir)/.packages"
	doins ${MY_P%-*}.gpd
}
