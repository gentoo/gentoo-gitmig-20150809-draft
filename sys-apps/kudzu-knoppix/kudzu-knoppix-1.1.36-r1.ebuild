# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kudzu-knoppix/kudzu-knoppix-1.1.36-r1.ebuild,v 1.3 2005/04/06 18:51:30 corsair Exp $

MY_PV=${PV}-2
S=${WORKDIR}/kudzu-${PV}
DESCRIPTION="Knoppix version of the Red Hat hardware detection tools"
HOMEPAGE="http://www.knopper.net/"
SRC_URI="http://developer.linuxtag.net/knoppix/sources/${PN}_${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc alpha -sparc -mips ppc64"
IUSE="livecd"

RDEPEND="!livecd? ( dev-libs/newt )"
DEPEND="$RDEPEND
	!livecd? ( sys-devel/gettext )
	!livecd? ( sys-libs/slang )
	sys-apps/pciutils
	!livecd? ( >=dev-libs/dietlibc-0.20 )
	!sys-apps/kudzu"

src_compile() {
	if use livecd; then
		emake libkudzu.a || die
	else
		emake || die
	fi

	if [ "${ARCH}" = "x86" -o "${ARCH}" = "ppc" ]
	then
		cd ddcprobe || die
		emake || die
	fi
}

src_install() {
	if use livecd; then
		dodir /etc/sysconfig
		dodir /usr/include/kudzu
		insinto /usr/include/kudzu
		doins *.h
		dolib.a libkudzu.a
	else
		einstall install-program DESTDIR=${D} PREFIX=/usr \
			MANDIR=/usr/share/man || die "Install failed"
	fi

	if [ "${ARCH}" = "x86" -o "${ARCH}" = "ppc" ]
	then
		cd ${S}/ddcprobe || die
		dosbin ddcxinfo ddcprobe || die
	fi
}
