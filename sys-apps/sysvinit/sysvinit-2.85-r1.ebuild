# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sysvinit/sysvinit-2.85-r1.ebuild,v 1.8 2004/11/12 14:37:23 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="/sbin/init - parent of all processes"
HOMEPAGE="http://freshmeat.net/projects/sysvinit/"
SRC_URI="ftp://ftp.cistron.nl/pub/people/miquels/software/${P}.tar.gz
	ftp://sunsite.unc.edu/pub/Linux/system/daemons/init/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="selinux bootstrap build"

RDEPEND="selinux? ( >=sys-libs/libselinux-1.14 )"
DEPEND="${RDEPEND}
	virtual/os-headers"

src_unpack() {
	unpack ${A}
	cd ${S}/src || die

	# SELinux patch
	use selinux && epatch ${FILESDIR}/sysvinit-${PV}-selinux.patch
}

src_compile() {
	# Note: The LCRYPT define below overrides the test in
	# sysvinit's Makefile.  This is because sulogin must be linked
	# to libcrypt in any case, but when building stage2 in
	# catalyst, /usr/lib/libcrypt.a isn't available.  In truth
	# this doesn't change how sulogin is built since ld would use
	# the shared obj by default anyway!  The other option is to
	# refrain from building sulogin, but that isn't a good option.
	# (09 Jul 2004 agriffis)
	emake -C ${S}/src CC="$(tc-getCC)" LD="$(tc-getCC)" \
		LDFLAGS="${LDFLAGS}" CFLAGS="${CFLAGS} -D_GNU_SOURCE" \
		LCRYPT="-lcrypt" || die
}

src_install() {
	cd ${S}/src
	into /
	dosbin init halt killall5 runlevel shutdown sulogin || die "dosbin"
	dosym init /sbin/telinit
	dobin last mesg utmpdump wall || die "dobin"
	dosym killall5 /sbin/pidof
	dosym halt /sbin/reboot
	dosym halt /sbin/poweroff
	dosym last /bin/lastb
	insinto /usr/include
	doins initreq.h

	# sysvinit docs
	cd ${S}
	doman man/*.[1-9]
	dodoc README doc/*

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

pkg_postinst() {
	# Reload init to fix unmounting problems of / on next reboot.
	# This is really needed, as without the new version of init cause init
	# not to quit properly on reboot, and causes a fsck of / on next reboot.
	if [[ ${ROOT} == / ]] && ! use build && ! use bootstrap; then
		# Do not return an error if this fails
		/sbin/init U &>/dev/null
	fi
}
