# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grub/grub-0.92-r1.ebuild,v 1.11 2003/04/11 18:12:13 method Exp $

inherit mount-boot eutils flag-o-matic

filter-flags "-fstack-protector"

S=${WORKDIR}/${P}
DESCRIPTION="GNU GRUB boot loader"
SRC_URI="ftp://alpha.gnu.org/gnu/grub/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/grub/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc -alpha -mips"

DEPEND=">=sys-libs/ncurses-5.2-r5"

PROVIDE="virtual/bootloader"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	epatch ${FILESDIR}/${P}/grub-0.92-vga16.patch
	epatch ${FILESDIR}/${P}/grub-0.5.96.1-special-raid-devices.patch
	epatch ${FILESDIR}/${P}/grub-0.90-configfile.patch
	epatch ${FILESDIR}/${P}/grub-0.90-vga16-keypressclear.patch
	epatch ${FILESDIR}/${P}/grub-0.90-passwordprompt.patch
	epatch ${FILESDIR}/${P}/grub-0.90-install.in.patch
	epatch ${FILESDIR}/${P}/grub-0.90-installcopyonly.patch
	epatch ${FILESDIR}/${P}/grub-0.90-staticcurses.patch
	epatch ${FILESDIR}/${P}/grub-0.90-symlinkmenulst.patch
	epatch ${FILESDIR}/${P}/grub-0.90-append.patch
	epatch ${FILESDIR}/${P}/grub-0.90-addsyncs.patch
	epatch ${FILESDIR}/${P}/grub-0.91-splashimagehelp.patch
	epatch ${FILESDIR}/${P}/grub-0.91-bootonce.patch
	epatch ${FILESDIR}/${P}/grub-0.92-automake16.patch
	epatch ${FILESDIR}/${P}/grub-0.92-nodeprecatedflags.patch
	epatch ${FILESDIR}/${P}/grub-0.91-vga16-serial.patch
	epatch ${FILESDIR}/${P}/grub-0.92-usbfix.patch
}

src_compile() {
	#i686-specific code in the boot loader is a bad idea; disabling to ensure 
	#at least some compatibility if the hard drive is moved to an older or 
	#incompatible system.
	unset CFLAGS
	./configure --prefix=/usr \
		--sbindir=/sbin \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--disable-auto-linux-mem-opt \
		|| die "Configuration of package failed."

	#the vga16.patch changes configure.in but not configure so
	#--enable-vga16 doesnt work.  config.h gets overwritten by make.
	echo "#define VGA16 1" >> config.h.in

	emake || die "Building failed!"
}

src_install() {
	make prefix=${D}/usr \
		sbindir=${D}/sbin \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die "Installation failed."

	dodir /boot/grub
	cp ${FILESDIR}/splash.xpm.gz ${D}/boot/grub
	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README THANKS TODO
}

pkg_postinst() {
	[ "$ROOT" != "/" ] && return 0
	if [ ! -e /boot/grub/stage1 ]
	then
		#if the boot loader files aren't in place, copy them over.
		cd /usr/share/grub/i386-pc
		cp stage1 stage2 *stage1_5 /boot/grub
	else
		einfo '*** A new GRUB has been installed. If you need to reinstall'
		einfo '*** GRUB to a boot record on your drive, please remember to'
		einfo '*** "cp /usr/share/grub/i386-pc/*stage* /boot/grub" first.'
		einfo "*** If you're using XFS, unmount and remount /boot as well."
	fi

	# change menu.lst to grub.conf
	if [ ! -e /boot/grub/grub.conf -a -e /boot/grub/menu.lst ]
	then
		mv /boot/grub/menu.lst /boot/grub/grub.conf
		ln -s grub.conf /boot/grub/menu.lst
		einfo "*** IMPORTANT NOTE: menu.lst has been renamed to grub.conf"
	fi
}
