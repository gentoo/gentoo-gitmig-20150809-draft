# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grub/grub-0.90-r5.ebuild,v 1.1 2002/02/04 12:52:58 gbevin Exp $


S=${WORKDIR}/${P}
DESCRIPTION="GNU GRUB boot loader"
SRC_URI="ftp://alpha.gnu.org/gnu/grub/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/grub"

DEPEND="virtual/glibc
        >=sys-libs/ncurses-5.2-r2"

pkg_setup() {
	if [ `cut -f 2 -d " " /proc/mounts | grep "/boot"` ]
	then
		einfo "Your boot partition was detected as being mounted as /boot."
		einfo "Files will be installed there for grub to function correctly."
	else
		mount /boot
		if [ `cut -f 2 -d " " /proc/mounts | grep "/boot"` ]
		then
			einfo "Your boot partition was not mounted as /boot, but portage was able to mount"
			einfo "it without additional intervention."
			einfo "Files will be installed there for grub to function correctly."
		else
			eerror "Your boot partition has to be mounted on /boot before the installation"
			eerror "can continue. Grub needs to install important files there."
			die "Please mount your /boot partition."
		fi
	fi
}

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}/grub-0.5.97-vga16.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.5.96.1-special-raid-devices.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.5.96.1-dont-give-mem-to-kernel.patch || die
#	patch -p1 < ${FILESDIR}/${P}/grub-0.90-configfile.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.90-vga16-keypressclear.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.90-passwordprompt.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-jfs+xfs-1.0-core.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-jfs+xfs-1.0-build.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.90-install.in.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.90-installcopyonly.patch || die
	cp -a ${FILESDIR}/${P}/configure .
}

src_compile() {

	./configure --prefix=/usr \
		--sbindir=/sbin \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--host=${CHOST} || die "Configuration of package failed."

	# Have to do this since the configure-script seems a little brooken
	echo "#define VGA16 1" >> config.h

	emake -e CPPFLAGS="-Wall -Wmissing-prototypes -Wunused 		  \
	                   -Wshadow -malign-jumps=1 -malign-loops=1	  \
		  	   -malign-functions=1 -Wundef" || die "Building failed."
}

src_install() {
	
	make prefix=${D}/usr \
		sbindir=${D}/sbin \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die "Installation failed."
	
	if [ -z "`use bootcd`" ]
	then
		dodir /boot/grub
		cd ${D}/usr/share/grub/i386-pc
		cp stage1 stage2 *stage1_5 ${D}/boot/grub
		cp ${FILESDIR}/${P}/splash.xpm.gz ${D}/boot/grub
		
		cd ${S}
		dodoc AUTHORS BUGS COPYING ChangeLog NEWS README THANKS TODO
	else
		rm -rf ${D}/usr/share/{man,info,doc}
	fi
}
