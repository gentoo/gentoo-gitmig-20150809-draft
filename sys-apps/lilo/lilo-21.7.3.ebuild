# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lilo/lilo-21.7.3.ebuild,v 1.1 2001/04/18 19:03:14 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard Linux boot loader"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/boot/lilo/"${A}

DEPEND="virtual/glibc
        >=sys-devel/bin86-0.15.4-r1"

RDEPEND="virtual/glibc"

src_unpack() {

    unpack ${A}
    cd ${S}
    cp Makefile Makefile.orig
    sed -e "s:-g:${CFLAGS}:" \
        Makefile.orig > Makefile

}

src_compile() {

    try pmake
}

src_install() {

        into /
	dosbin lilo
	into /usr
	dosbin keytab-lilo.pl
	dodir /boot
	insinto /boot
	doins boot-text.b boot-menu.b chain.b os2_d.b
	doman manPages/*.[5-8]
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
	ln -sf boot-menu.b $ROOT/boot/boot.b;

}


