# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kudzu-knoppix/kudzu-knoppix-1.1.36-r1.ebuild,v 1.8 2005/06/22 14:03:52 wolf31o2 Exp $

inherit eutils

MY_PV=${PV}-2
S=${WORKDIR}/kudzu-${PV}
DESCRIPTION="Knoppix version of the Red Hat hardware detection tools"
HOMEPAGE="http://www.knopper.net/"
SRC_URI="http://developer.linuxtag.net/knoppix/sources/${PN}_${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 -mips ppc ppc64 ~sparc x86"
IUSE="livecd nls"

RDEPEND="!livecd? ( dev-libs/newt )"
DEPEND="${RDEPEND}
	!livecd? (
		sys-devel/gettext
		sys-libs/slang
		>=dev-libs/dietlibc-0.20
	)
	sys-apps/pciutils
	!sys-apps/kudzu"

src_unpack() {
	unpack ${A}
	if ! use nls; then
		epatch "${FILESDIR}/${P}-nonls-v4.patch" || die "epatch failed"
	fi
}

src_compile() {
	# Fix the modules directory to match Gentoo layout.
	perl -pi -e 's|/etc/modutils/kudzu|/etc/modules.d/kudzu|g' *.*

	if use livecd; then
		emake libkudzu.a RPM_OPT_FLAGS="${CFLAGS}" || die
	else
		emake RPM_OPT_FLAGS="${CFLAGS}" || die
	fi

	if use x86 || use ppc
	then
		cd ddcprobe || die
		emake RPM_OPT_FLAGS="${CFLAGS}" || die
	fi
}

src_install() {
	if use livecd; then
		dodir /etc/sysconfig
		insinto /usr/include/kudzu
		doins *.h
		dolib.a libkudzu.a
	else
		einstall install-program DESTDIR=${D} PREFIX=/usr \
			MANDIR=/usr/share/man || die "Install failed"
		# Init script isn't appropriate
		rm -rf ${D}/etc/rc.d
		# Add our own init scripts
		newinitd ${FILESDIR}/${PN/-knoppix}.rc ${PN/-knoppix} || die
		newconfd ${FILESDIR}/${PN/-knoppix}.conf.d ${PN/-knoppix} || die
	fi

	if use x86 || use ppc
	then
		cd ${S}/ddcprobe || die
		dosbin ddcxinfo ddcprobe || die
	fi
}
