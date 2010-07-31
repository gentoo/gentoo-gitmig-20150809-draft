# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/gauche-cdb/gauche-cdb-0.3.1.ebuild,v 1.10 2010/07/31 09:50:45 hattya Exp $

EAPI="2"

inherit autotools eutils

IUSE=""

MY_P="${P/g/G}"

DESCRIPTION="CDB binding for Gauche"
HOMEPAGE="http://sourceforge.jp/projects/gauche/"
SRC_URI="mirror://sourceforge.jp/gauche/8407/${MY_P}.tar.gz"

LICENSE="BSD"
KEYWORDS="ia64 x86"
SLOT="0"
S="${WORKDIR}/${MY_P}"

DEPEND="dev-scheme/gauche
	dev-db/tinycdb"

src_prepare() {

	epatch "${FILESDIR}"/*.diff
	eautoreconf

}

src_install() {

	emake DESTDIR="${D}" install || die
	dodoc README

	insinto "$(gauche-config --sitelibdir)/.packages"
	doins ${MY_P%-*}.gpd

}
