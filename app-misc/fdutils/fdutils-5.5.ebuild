# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fdutils/fdutils-5.5.ebuild,v 1.3 2005/07/16 10:48:11 dragonheart Exp $

inherit eutils flag-o-matic

DESCRIPTION="utilities for configuring and debugging the Linux floppy driver"
HOMEPAGE="http://fdutils.linux.lu/"
SRC_URI="http://fdutils.linux.lu/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="doc"

DEPEND=">=sys-fs/mtools-3
	doc? ( virtual/tetex )"

src_unpack() {
	unpack ${A}
	cd ${S}
	# the man 4 fd manpage is better in the man-pages package, so stop it
	# from installing
	epatch ${FILESDIR}/${PN}-no-fd.4-manpage.diff
	epatch ${FILESDIR}/${P}-destdirfix.patch
}

src_compile() {
	econf --enable-fdmount-floppy-only || die
	append-cflags '-Wl,-z,now'

	if use doc;
	then
		make || die
	else
		make compile || die
	fi
}

src_install() {
	dodoc Changelog
	emake DESTDIR=${D} install || die
}
