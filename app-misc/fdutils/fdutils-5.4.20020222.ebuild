# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fdutils/fdutils-5.4.20020222.ebuild,v 1.10 2003/09/05 12:10:36 msterret Exp $

inherit eutils

DESCRIPTION="utilities for configuring and debugging the Linux floppy driver"
HOMEPAGE="http://fdutils.linux.lu/"
SRC_URI="http://fdutils.linux.lu/fdutils-5.4.tar.gz
	 http://fdutils.linux.lu/fdutils-5.4-20020222.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=mtools-3
	>=tetex-1.0.7-r10"

S=${WORKDIR}/${PN}-5.4

src_unpack() {
	unpack fdutils-5.4.tar.gz
	epatch ${DISTDIR}/${PN}-5.4-20020222.diff.gz
}

src_compile() {
	econf --enable-fdmount-floppy-only || die
	make || die
}

src_install() {
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
