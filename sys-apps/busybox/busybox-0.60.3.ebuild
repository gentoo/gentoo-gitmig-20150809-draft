# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/busybox/busybox-0.60.3.ebuild,v 1.1 2002/05/20 22:36:33 wmertens Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utilities for rescue and embedded systems"
SRC_URI="ftp://oss.lineo.com/busybox/${P}.tar.gz"
HOMEPAGE="http://busybox.lineo.com/"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/Config.h-${PV}-cd ${S}/Config.h
	# I did not include the msh patch since I don't know if it will
	# break stuff, I compile ash anyway, and it's in CVS
}

src_compile() {
	# If the var BUSYBOX_STATIC is set, it will buid a static busybox
	[ -n "$BUSYBOX_STATIC" ] && myconf="$myconf DOSTATIC=true"
	emake $myconf || die
}

src_install () {
	into /    
	dobin busybox
	into /usr
	dodoc AUTHORS Changelog LICENSE README TODO
	
	cd docs
	doman *.1
	docinto txt
	dodoc *.txt
	docinto sgml
	dodoc *.sgml
	docinto pod
	dodoc *.pod
	docinto html
	dodoc *.html

	cd ../scripts
	docinto scripts
	dodoc inittab
	dodoc depmod.pl
}

