# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grub/grub-0.93.20030118.ebuild,v 1.7 2003/04/11 18:12:13 method Exp $

inherit mount-boot eutils flag-o-matic

filter-flags "-fstack-protector"

NEWP=${PN}-${PV%.*}
S=${WORKDIR}/${NEWP}
DESCRIPTION="GNU GRUB boot loader"
SRC_URI="ftp://alpha.gnu.org/gnu/grub/${NEWP}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2"
HOMEPAGE="http://www.gnu.org/software/grub/"
KEYWORDS="~x86 -ppc -sparc -alpha -mips"
SLOT="0"
LICENSE="GPL-2"
DEPEND=">=sys-libs/ncurses-5.2-r5"
PROVIDE="virtual/bootloader"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	# grub-0.93.20030118-gentoo.diff; <woodchip@gentoo.org> (18 Jan 2003)
	# -fixes from grub CVS pulled on 20030118
	# -vga16 patches; mined from Debian's grub-0.93+cvs20030102-1.diff
	# -special-raid-devices.patch
	# -addsyncs.patch
	# -splashimagehelp.patch
	# -configfile.patch
	# -installcopyonly.patch
	epatch ${DISTDIR}/${P}-gentoo.diff.bz2
	WANT_AUTOCONF_2_5=1 autoconf || die
}

src_compile() {
	### i686-specific code in the boot loader is a bad idea; disabling to ensure 
	### at least some compatibility if the hard drive is moved to an older or 
	### incompatible system.
	unset CFLAGS

	econf --exec-prefix=/ \
		--disable-auto-linux-mem-opt || die
	emake || die
}

src_install() {
	einstall exec_prefix=${D}/ || die

	insinto /boot/grub
	doins ${FILESDIR}/splash.xpm.gz
	newins docs/menu.lst grub.conf.sample

	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README THANKS TODO
	newdoc docs/menu.lst grub.conf.sample
}

pkg_postinst() {
	[ "$ROOT" != "/" ] && return 0
	/sbin/grub-install --just-copy

	# change menu.lst to grub.conf
	if [ ! -e /boot/grub/grub.conf -a -e /boot/grub/menu.lst ]
	then
		mv /boot/grub/menu.lst /boot/grub/grub.conf
		ln -s grub.conf /boot/grub/menu.lst
		ewarn
		ewarn "*** IMPORTANT NOTE: menu.lst has been renamed to grub.conf"
		ewarn
	fi
}
