# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/sys-apps/grub/grub-0.90-r7.ebuild,v 1.1 2002/03/08 08:54:04 blocke Exp

S=${WORKDIR}/${P}
DESCRIPTION="GNU GRUB boot loader"
SRC_URI="ftp://alpha.gnu.org/gnu/grub/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/grub"
KEYWORDS="x86 -ppc -sparc -sparc64"
SLOT="0"
LICENSE="GPL-2"

RDEPEND=">=sys-libs/ncurses-5.2-r5"

DEPEND="${RDEPEND}
	sys-apps/grep 
	sys-apps/sed"
	
pkg_setup() {
	[ "$ROOT" != "/" ] && return 0
	#If the user doesn't have a /boot or /mnt/boot filesystem, skip.
	[ -z "`grep /boot /etc/fstab | grep -v "^[ \t]*#"`" ] || return 0 
	local myboot
	myboot=`cat /etc/fstab | grep -v ^# | grep /boot | sed -e 's/^[^[:space:]]*[[:space:]]*\([^[:space:]]*\).*$/\1/'`
	[ `cat /proc/mounts | cut -f2 -d" " | grep $myboot` ] && return 0
	mount $myboot
	if [ $? -ne 0 ]
	then
		eerror "GRUB installation requires that $myboot is mounted or mountable."
		eerror "If you do not have a seperate /boot partition please remove any"
		eerror "/boot entries from /etc/fstab and make sure /boot exists."
		eerror ""
		eerror "Unable to mount $myboot automatically; exiting."
		die "Please mount your $myboot filesystema and remerge this ebuild."
	fi
}
src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}/grub-0.92-vga16.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.5.96.1-special-raid-devices.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.90-configfile.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.90-vga16-keypressclear.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.90-passwordprompt.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.90-install.in.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.90-installcopyonly.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.90-staticcurses.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.90-symlinkmenulst.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.90-append.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.90-addsyncs.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.91-splashimagehelp.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.91-bootonce.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.92-automake16.patch || die
	patch -p0 < ${FILESDIR}/${P}/grub-0.92-nodeprecatedflags.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.91-vga16-serial.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.92-usbfix.patch || die

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

	emake || die "Building failed!"
}

src_install() {
	make prefix=${D}/usr \
		sbindir=${D}/sbin \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die "Installation failed."
	
	dodir /boot/grub
	cd ${D}/usr/share/grub/i386-pc
	cp ${FILESDIR}/splash.xpm.gz ${D}/boot/grub
	cd ${S}
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
		einfo '*** A new GRUB has been installed. If you need to reinstall GRUB to a'
		einfo '*** boot record on your drive, please remember to'
		einfo '*** "cp /usr/share/grub/i386-pc/*stage* /boot/grub" first.'
		einfo "*** If you're using XFS, unmount and remount /boot as well."
		einfo "*** Note that menu.lst now is called grub.conf."
	fi
}

