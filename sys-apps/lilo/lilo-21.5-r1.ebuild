# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lilo/lilo-21.5-r1.ebuild,v 1.1 2000/08/02 17:07:13 achim Exp $

P=lilo-21.5
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard Linux boot loader"
CATEGORY="sys-apps"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/boot/lilo/"${A}

src_compile() {                           
    make
}

src_install() {                               
	into /
	dosbin lilo
	into /usr
	dosbin keytab-lilo.pl
	dodir /boot
	insinto /boot
	doins boot-text.b boot-menu.b chain.b os2_d.b
	dodoc CHANGES COPYING INCOMPAT QuickInst README*
}

pkg_preinst() {

	. ${ROOT}/etc/rc.d/config/functions

	if [ ! -L $ROOT/boot/boot.b -a -f $ROOT/boot/boot.b ]
	then
	    einfo "Saving old boot.b..."
	    mv $ROOT/boot/boot.b $ROOT/boot/boot.old; 
	fi

	if [ ! -L $ROOT/boot/chain.b -a -f $ROOT/boot/chain.b ]
	then
	    einfo "Saving old chain.b..."
	    mv $ROOT/boot/chain.b $ROOT/boot/chain.old;
	fi

	if [ ! -L $ROOT/boot/os2_d.b -a -f $ROOT/boot/os2_d.b ]
	then
	    einfo "Saving old os2_d.b..."
	    mv $ROOT/boot/os2_d.b $ROOT/boot/os2_d.old;
	fi
}

pkg_postinst() {

	. ${ROOT}/etc/rc.d/config/functions

	einfo "Activating boot-menu..."
	ln -s boot-menu.b $ROOT/boot/boot.b;

}


