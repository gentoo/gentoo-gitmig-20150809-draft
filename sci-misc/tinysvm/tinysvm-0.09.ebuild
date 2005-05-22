# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/tinysvm/tinysvm-0.09.ebuild,v 1.1 2005/05/22 16:28:49 usata Exp $

MY_PN="TinySVM"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="TinySVM is an implementation of Support Vector Machines (SVMs) for
pattern recognition."
HOMEPAGE="http://chasen.org/~taku/software/TinySVM/"
SRC_URI="http://chasen.org/~taku/software/TinySVM/src/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
#IUSE="perl java python ruby"

DEPEND=""
#RDEPEND=""

src_test() {
	make check || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS README THANKS
}
