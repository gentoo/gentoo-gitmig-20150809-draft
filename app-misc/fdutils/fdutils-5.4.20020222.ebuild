# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fdutils/fdutils-5.4.20020222.ebuild,v 1.4 2002/08/13 21:23:31 satai Exp $

S=${WORKDIR}/${PN}-5.4
DESCRIPTION="The fdutils package contains utilities for configuring and debugging the Linux floppy driver"
SRC_URI="http://fdutils.linux.lu/fdutils-5.4.tar.gz
	 http://fdutils.linux.lu/fdutils-5.4-20020222.diff.gz"
HOMEPAGE="http://fdutils.linux.lu/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=mtools-3
		>=tetex-1.0.7-r10"

src_unpack() {
	unpack fdutils-5.4.tar.gz
	gunzip -c ${DISTDIR}/${PN}-5.4-20020222.diff.gz | patch -p0
}

src_compile() {
	econf --enable-fdmount-floppy-only || die
	make || die
}

src_install () {
	# since the Makefiles doesnt support $DESTDIR we'll do it manually 
	# instead of patching the Makefile.in

	cd src
	dobin MAKEFLOPPIES diskd floppycontrol floppymeter getfdprm setfdprm
	dobin fdrawcmd fdmount
	cd ${S}

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
