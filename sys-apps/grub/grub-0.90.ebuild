# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <hallski@gentoo.org>
# /home/cvsroot/gentoo-x86/sys-apps/grub/grub-0.5.96.1-r2.ebuild,v 1.2 2001/02/07 20:05:43 achim Exp

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNU GRUB boot loader"
SRC_URI="ftp://alpha.gnu.org/gnu/grub/${A}"
HOMEPAGE="http://www.gnu.org/software/grub"

DEPEND="virtual/glibc
        >=sys-libs/ncurses-5.2-r2"

src_unpack() {
	unpack ${A}
	cd ${S}
	try patch -p1 < ${FILESDIR}/${P}/grub-0.5.97-vga16.patch
	try patch -p1 < ${FILESDIR}/${P}/grub-0.5.96.1-special-raid-devices.patch
	try patch -p1 < ${FILESDIR}/${P}/grub-0.5.96.1-dont-give-mem-to-kernel.patch
#	try patch -p1 < ${FILESDIR}/${P}/grub-0.90-configfile.patch
	try patch -p1 < ${FILESDIR}/${P}/grub-0.90-vga16-keypressclear.patch
	try patch -p1 < ${FILESDIR}/${P}/grub-0.90-passwordprompt.patch
	try patch -p1 < ${FILESDIR}/${P}/grub-0.90-install.in.patch
	try patch -p1 < ${FILESDIR}/${P}/grub-0.90-installcopyonly.patch
}

src_compile() {

	./configure --prefix=/usr --sbindir=/sbin 			  \
                    --mandir=/usr/share/man --infodir=/usr/share/info 	  \
		    --host=${CHOST} 
	assert "Configuration of package failed."

	# Have to do this since the configure-script seems a little brooken
	echo "#define VGA16 1" >> config.h

	emake -e CPPFLAGS="-Wall -Wmissing-prototypes -Wunused 		  \
	                   -Wshadow -malign-jumps=1 -malign-loops=1	  \
		  	   -malign-functions=1 -Wundef"
        assert "Building failed."
}

src_install() {
	
	make prefix=${D}/usr sbindir=${D}/sbin mandir=${D}/usr/share/man  \
	     infodir=${D}/usr/share/info install
	assert "Installation failed."
	
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
