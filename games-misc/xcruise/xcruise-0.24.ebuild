# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/xcruise/xcruise-0.24.ebuild,v 1.3 2004/03/10 17:29:05 vapier Exp $

DESCRIPTION="Fly about 3D-formed file system"
HOMEPAGE="http://tanaka-www.cs.titech.ac.jp/%7Eeuske/prog/"
SRC_URI="http://tanaka-www.cs.titech.ac.jp/%7Eeuske/prog/${P}.tar.gz
	http://members.optushome.com.au/psylence/xcruise.man"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc amd64"

DEPEND="virtual/x11"

src_compile() {
	cp ${DISTDIR}/xcruise.man .
	xmkmf -a
	make || die "could not make"
}

src_install() {
	dobin xcruise || die
	newman xcruise.man xcruise.1
}
