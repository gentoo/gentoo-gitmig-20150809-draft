# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/furball/furball-0.5.ebuild,v 1.14 2003/03/11 21:11:42 seemant Exp $

DESCRIPTION="A handy backup script utilizing tar"
SRC_URI="http://www.claws-and-paws.com/software/furball/${P}.tgz"
HOMEPAGE="http://www.claws-and-paws.com/software/furball/index.shtml"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

RDEPEND="dev-lang/perl
	sys-apps/tar"

src_install() {
	dobin furball
	doman furball.1
	dodoc README NEWS THANKS
}
