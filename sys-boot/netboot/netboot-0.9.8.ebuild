# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/netboot/netboot-0.9.8.ebuild,v 1.4 2006/12/09 12:08:01 masterdriverz Exp $

DESCRIPTION="x86 specific netbooting utility"
HOMEPAGE="http://netboot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

RDEPEND="!net-misc/mknbi"
DEPEND="$RDEPEND
	sys-devel/autoconf"

src_install() {
	# this method does not work thanks to a icky Makefile, so we use einstall instead
	# DESTDIR="${D}" make install || die
	einstall || die "einstall failed"
	dodoc README version
	docinto FlashCard
	dodoc FlashCard/*
}
