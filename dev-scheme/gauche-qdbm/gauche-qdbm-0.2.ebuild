# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/gauche-qdbm/gauche-qdbm-0.2.ebuild,v 1.6 2008/06/19 15:29:46 hattya Exp $

inherit autotools eutils

IUSE=""

MY_P="${P/g/G}"

DESCRIPTION="QDBM binding for Gauche"
HOMEPAGE="http://sourceforge.jp/projects/gauche/"
SRC_URI="mirror://sourceforge.jp/gauche/6988/${MY_P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~sparc x86"
SLOT="0"
S="${WORKDIR}/${MY_P}"

DEPEND="dev-scheme/gauche
	dev-db/qdbm"

src_unpack() {

	unpack ${A}
	cd "${S}"

	if has_version '>=dev-scheme/gauche-0.8'; then
		epatch "${FILESDIR}"/${P}-gpd.diff
		eautoreconf
	fi

}

src_install() {

	emake DESTDIR="${D}" install || die
	dodoc README

	if has_version '>=dev-scheme/gauche-0.8'; then
		insinto $(gauche-config --sitelibdir)/.packages
		doins ${MY_P%-*}.gpd
	fi

}
