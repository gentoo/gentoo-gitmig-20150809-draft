# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/xcruise/xcruise-0.24.ebuild,v 1.1 2003/09/10 18:14:05 vapier Exp $

DESCRIPTION="Fly about 3D-formed file system"
SRC_URI="http://tanaka-www.cs.titech.ac.jp/%7Eeuske/prog/${P}.tar.gz
	http://members.optushome.com.au/psylence/xcruise.man"
HOMEPAGE="http://tanaka-www.cs.titech.ac.jp/%7Eeuske/prog/"

KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="as-is"

DEPEND="virtual/x11"
S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${P}.tar.gz
}

src_compile() {
	cp ${DISTDIR}/xcruise.man .
	xmkmf -a
	make || die "could not make"
}

src_install() {
	dobin xcruise

	mv xcruise.man xcruise.1
	doman xcruise.1
}
