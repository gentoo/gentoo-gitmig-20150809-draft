# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mkisofs/mkisofs-1.13-r2.ebuild,v 1.12 2003/04/17 17:04:13 wwoods Exp $
# -r2 by Dan Armak

DESCRIPTION="Premastering program for creating iso9660 volumes"
HOMEPAGE="http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/mkisofs.html"
KEYWORDS="x86 ppc sparc alpha"
SLOT="0"
LICENSE="GPL-2"

S=${WORKDIR}/${P}
SRC_URI="ftp://ftp.fokus.gmd.de/pub/unix/cdrecord/mkisofs/${P}.tar.gz"

src_compile() {

	emake || die

}

src_install() {							   
	
	into /usr
	local DIR

	#looks like these are no longer used
	[ -d mkisofs/OBJ/i686-linux-cc ] && DIR=i686-linux-cc
	[ -d mkisofs/OBJ/i586-linux-cc ] && DIR=i586-linux-cc
	[ -d mkisofs/OBJ/i486-linux-cc ] && DIR=i486-linux-cc
	[ -d mkisofs/OBJ/i386-linux-cc ] && DIR=i386-linux-cc

	#these should work instead (sparc guys need to add theirs here too)
	[ -d mkisofs/OBJ/x86-linux-cc ] && DIR=x86-linux-cc
	[ -d mkisofs/OBJ/ppc-linux-cc ] && DIR=ppc-linux-cc
	
	dobin mkisofs/OBJ/${DIR}/mkisofs
	dobin mkisofs/diag/OBJ/${DIR}/devdump
	dobin mkisofs/diag/OBJ/${DIR}/isodump
	dobin mkisofs/diag/OBJ/${DIR}/isoinfo
	dobin mkisofs/diag/OBJ/${DIR}/isovfy
	
	doman mkisofs/mkisofs.8 mkisofs/mkhybrid.8 mkisofs/apple_driver.8
	doman mkisofs/diag/isoinfo.8
	dodoc ABOUT BUILD COMPILE COPYING MKNOD* PORTING README*
	docinto mkisofs
	dodoc mkisofs/ChangeLog
	dodoc mkisofs/README* mkisofs/TODO
	
}
