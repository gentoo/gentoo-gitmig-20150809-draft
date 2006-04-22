# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/gauche-qdbm/gauche-qdbm-0.2.ebuild,v 1.4 2006/04/22 15:26:44 hattya Exp $

inherit eutils

IUSE=""

MY_P="${P/g/G}"

DESCRIPTION="QDBM binding for Gauche"
HOMEPAGE="http://sourceforge.jp/projects/gauche/"
SRC_URI="mirror://sourceforge.jp/gauche/6988/${MY_P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~sparc x86"
SLOT="0"
S="${WORKDIR}/${MY_P}"

DEPEND="dev-lang/gauche
	dev-db/qdbm"

src_unpack() {

	unpack ${A}
	cd ${S}

	if has_version '>=dev-lang/gauche-0.8'; then
		epatch ${FILESDIR}/${P}-gpd.diff

		aclocal
		autoconf
	fi

}

src_install() {

	make DESTDIR=${D} install || die
	dodoc README

	if has_version '>=dev-lang/gauche-0.8'; then
		insinto $(gauche-config --sitelibdir)/.packages
		doins ${MY_P%-*}.gpd
	fi

}
