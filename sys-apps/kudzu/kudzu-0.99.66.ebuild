# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kudzu/kudzu-0.99.66.ebuild,v 1.8 2003/06/21 21:19:40 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Red Hat Hardware detection tools"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.knopper.net"

KEYWORDS="x86 amd64 -ppc -sparc -alpha -mips"
SLOT="0"
LICENSE="GPL-2"

RDEPEND="dev-libs/newt"
DEPEND="$RDEPEND sys-apps/pciutils >=dev-libs/dietlibc-0.20"

src_compile() {
	emake  || die
	cd ddcprobe || die
	emake || die
}

src_install() {
	einstall DESTDIR=${D} PREFIX=/usr MANDIR=/usr/share/man || die "Install failed"
	cd ${S}/ddcprobe || die
	dosbin svgamodes modetest ddcxinfo ddcprobe || die
}

