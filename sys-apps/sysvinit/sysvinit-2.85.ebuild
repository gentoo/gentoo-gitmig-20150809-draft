# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sysvinit/sysvinit-2.85.ebuild,v 1.6 2004/11/05 01:30:50 vapier Exp $

inherit eutils

DESCRIPTION="/sbin/init - parent of all processes"
HOMEPAGE="http://freshmeat.net/projects/sysvinit/"
SRC_URI="ftp://ftp.cistron.nl/pub/people/miquels/software/${P}.tar.gz
	ftp://sunsite.unc.edu/pub/Linux/system/daemons/init/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~s390"
IUSE="selinux build"

RDEPEND="selinux? ( >=sys-libs/libselinux-1.14 )"
DEPEND="${RDEPEND}
	virtual/os-headers"

src_unpack() {
	unpack ${A}
	cd ${S}/src || die

	# Note that if sysvinit is ever built with USE=build, need to
	# refrain from building sulogin as it needs libcrypt which is
	# not in the build image:
	if use build; then
		sed -i -e '/^PROGS/s/ sulogin//' Makefile || die
	fi

	# SELinux patch
	use selinux && epatch ${FILESDIR}/sysvinit-${PV}-selinux.patch
}

src_compile() {
	cd ${S}/src
	emake CC="$(tc-getCC)" LD="$(tc-getCC)" \
		LDFLAGS="${LDFLAGS}" CFLAGS="${CFLAGS} -D_GNU_SOURCE" || die
}

src_install() {
	cd ${S}/src
	into /
	dosbin init halt killall5 runlevel shutdown sulogin
	dosym init /sbin/telinit
	dobin last mesg utmpdump wall
	dosym killall5 /sbin/pidof
	dosym halt /sbin/reboot
	dosym halt /sbin/poweroff
	dosym last /bin/lastb
	insinto /usr/include
	doins initreq.h

	# sysvinit docs
	cd ${S}
	doman man/*.[1-9]
	dodoc COPYRIGHT README doc/*

	# install our inittab
	insinto /etc
	doins ${FILESDIR}/inittab || die

	# Add serial console for arches that typically have it
	case ${ARCH} in
		sparc|mips|hppa|alpha|ia64|arm)
			sed -i -e \
				's"# TERMINALS"# SERIAL CONSOLE\nc0:12345:respawn:/sbin/agetty 9600 ttyS0 vt100\n\n&"' \
				${D}/etc/inittab || die
			;;
	esac
}
