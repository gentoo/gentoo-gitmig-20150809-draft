# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kudzu-knoppix/kudzu-knoppix-1.1.36.ebuild,v 1.7 2004/06/02 17:51:26 wolf31o2 Exp $

MY_PV=${PV}-2
S=${WORKDIR}/kudzu-${PV}
DESCRIPTION="Knoppix version of the Red Hat hardware detection tools"
SRC_URI="http://developer.linuxtag.net/knoppix/sources/${PN}_${MY_PV}.tar.gz"
HOMEPAGE="http://www.knopper.net"

KEYWORDS="x86 ~amd64 ~ppc ~alpha -sparc -mips"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND="dev-libs/newt"
DEPEND="$RDEPEND
	sys-libs/slang
	sys-apps/pciutils
	>=dev-libs/dietlibc-0.20
	!sys-apps/kudzu"

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

