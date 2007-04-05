# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sysvinit/sysvinit-2.86-r6.ebuild,v 1.7 2007/04/05 14:16:55 wolf31o2 Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="/sbin/init - parent of all processes"
HOMEPAGE="http://freshmeat.net/projects/sysvinit/"
SRC_URI="ftp://ftp.cistron.nl/pub/people/miquels/software/${P}.tar.gz
	ftp://sunsite.unc.edu/pub/Linux/system/daemons/init/${P}.tar.gz
	http://www.gc-linux.org/down/isobel/kexec/sysvinit/sysvinit-2.86-kexec.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE="selinux ibm static"

RDEPEND="selinux? ( >=sys-libs/libselinux-1.28 )"
DEPEND="${RDEPEND}
	virtual/os-headers"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	cp "${FILESDIR}"/change_console.{c,8} src/ || die
	epatch "${FILESDIR}"/${P}-docs.patch
	epatch "${FILESDIR}"/${P}-shutdown-usage.patch
	epatch "${FILESDIR}"/sysvinit-2.86-off-by-one.patch
	epatch "${DISTDIR}"/sysvinit-2.86-kexec.patch
	#epatch "${FILESDIR}"/sysvinit-2.86-POSIX-1003.1e.patch #5818
	epatch "${FILESDIR}"/sysvinit-2.86-execl.patch
	epatch "${FILESDIR}"/sysvinit-2.86-utmp-64bit.patch
	cd src
	epatch "${FILESDIR}"/${PV}-gentoo.patch
	use selinux && epatch "${FILESDIR}"/${PV}-selinux-1.patch

	# Mung inittab for specific architectures
	cd "${WORKDIR}"
	cp "${FILESDIR}"/inittab . || die "cp inittab"
	local insert=""
	use ppc && insert="#psc0:12345:respawn:/sbin/agetty 115200 ttyPSC0 linux\n"
	use arm && insert='#f0:12345:respawn:/sbin/agetty 9600 ttyFB0 vt100'
	use hppa && insert='b0:12345:respawn:/sbin/agetty 9600 ttyB0 vt100'
	if use ibm ; then
		insert="${insert}#hvc0:2345:respawn:/sbin/agetty -L 9600 hvc0"$'\n'
		insert="${insert}#hvsi:2345:respawn:/sbin/agetty -L 19200 hvsi0"
	fi
	(use arm || use mips || use sh || use sparc) && sed -i '/ttyS0/s:#::' inittab
	[[ -n ${insert} ]] && echo "# Architecture specific features"$'\n'"${insert}" >> inittab
}

src_compile() {
	use static && append-ldflags -static

	# Note: The LCRYPT define below overrides the test in
	# sysvinit's Makefile.  This is because sulogin must be linked
	# to libcrypt in any case, but when building stage2 in
	# catalyst, /usr/lib/libcrypt.a isn't available.  In truth
	# this doesn't change how sulogin is built since ld would use
	# the shared obj by default anyway!  The other option is to
	# refrain from building sulogin, but that isn't a good option.
	# (09 Jul 2004 agriffis)
	emake -C src \
		CC="$(tc-getCC)" \
		DISTRO="Gentoo" \
		LCRYPT="-lcrypt" \
		all change_console \
		|| die
}

src_install() {
	dodoc README doc/*

	cd src
	make install DISTRO="Gentoo" ROOT="${D}" || die "make install"

	into /
	dosbin change_console || die
	doman change_console.8

	insinto /etc
	doins "${WORKDIR}"/inittab || die "inittab"

	doinitd "${FILESDIR}"/{reboot,shutdown}.sh || die
}

pkg_postinst() {
	# Reload init to fix unmounting problems of / on next reboot.
	# This is really needed, as without the new version of init cause init
	# not to quit properly on reboot, and causes a fsck of / on next reboot.
	if [[ ${ROOT} == / ]] ; then
		# Do not return an error if this fails
		/sbin/telinit U &>/dev/null
	fi
}
