# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kudzu/kudzu-1.1.43.ebuild,v 1.1 2004/02/17 15:25:48 dholm Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Red Hat Hardware detection tools"
SRC_URI="http://www.ibiblio.org/onebase/devbase/app-packs/${P}.tar.bz2"
HOMEPAGE="http://www.knopper.net"

KEYWORDS="~x86 ~amd64 ~ppc ~alpha -sparc -mips"
SLOT="0"
LICENSE="GPL-2"

RDEPEND="dev-libs/newt"
DEPEND="$RDEPEND sys-apps/pciutils >=dev-libs/dietlibc-0.20"

src_compile() {
	emake  || die

	if [ "${ARCH}" = "x86" -o "${ARCH}" = "ppc" ]
	then
		cd ddcprobe || die
		emake || die
	fi
}

src_install() {
	einstall install-program DESTDIR=${D} PREFIX=/usr MANDIR=/usr/share/man \
		|| die "Install failed"

	if [ "${ARCH}" = "x86" -o "${ARCH}" = "ppc" ]
	then
		cd ${S}/ddcprobe || die
		dosbin ddcxinfo ddcprobe || die
	fi
}

