# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.8 2002/05/30 01:54:49 sandymac Exp

DESCRIPTION="The fdutils package contains utilities for configuring and debugging the Linux floppy driver"
SRC_URI="http://fdutils.linux.lu/fdutils-5.4.tar.gz
	 http://fdutils.linux.lu/fdutils-5.4-20020222.diff.gz"
HOMEPAGE="http://fdutils.linux.lu/"
LICENSE="GPL-2"
DEPEND=">=mtools-3"
#RDEPEND=""
S=${WORKDIR}/${PN}-5.4

src_unpack() {
	unpack fdutils-5.4.tar.gz
	gunzip -c ${DISTDIR}/${PN}-5.4-20020222.diff.gz | patch -p0
}

src_compile() {
	cd ${S}
	./configure \
                --host=${CHOST} \
                --prefix=/usr \
                --infodir=/usr/share/info \
		--enable-fdmount-floppy-only \
                --mandir=/usr/share/man || die "./configure failed"



	#emake || die
	make || die
}

src_install () {
	# since the Makefiles doesnt support $DESTDIR we'll do it manually instead of patching the Makefile.in

	dobin src/MAKEFLOPPIES src/diskd src/floppycontrol src/floppymeter src/getfdprm src/setfdprm
	dobin src/fdrawcmd src/fdmount

	dosym /usr/bin/binxdfcopy /usr/bin/xdfformat
	dosym /usr/bin/fdmount /usr/bin/fdumount
	dosym /usr/bin/fdmount /usr/bin/fdlist
	dosym /usr/bin/fdmount /usr/bin/fdmountd
	
	insinto /etc
        doins src/mediaprm

	doinfo doc/fdutils.info*
	
	doman doc/*.1 doc/*.4

	dosym /usr/share/man/man1/fdmount.1.gz /usr/share/man/man1/fdumount.1.gz
	dosym /usr/share/man/man1/fdmount.1.gz /usr/share/man/man1/fdlist.1.gz
	dosym /usr/share/man/man1/fdmount.1.gz /usr/share/man/man1/fdmountd.1.gz
	dosym /usr/share/man/man1/xdfcopy.1.gz /usr/share/man/man1/xdfformat.1.gz

	dodoc Changelog

}
