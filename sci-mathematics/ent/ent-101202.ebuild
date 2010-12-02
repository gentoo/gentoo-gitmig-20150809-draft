# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/ent/ent-101202.ebuild,v 1.1 2010/12/02 17:46:05 jlec Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="Pseudorandom number sequence test"
HOMEPAGE="http://www.fourmilab.ch/random/"
SRC_URI="mirror://gentoo/random-${PV}.zip"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="public-domain"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${PV}-gentoo.patch
	tc-export CC
}

src_install() {
	dobin ${PN} || die
	dohtml ${PN}.html ${PN}itle.gif || die
}
