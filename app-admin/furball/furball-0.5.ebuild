# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/furball/furball-0.5.ebuild,v 1.19 2005/01/01 11:00:00 eradicator Exp $

DESCRIPTION="A handy backup script utilizing tar"
SRC_URI="http://www.claws-and-paws.com/software/furball/${P}.tgz"
HOMEPAGE="http://www.claws-and-paws.com/software/furball/index.shtml"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"
IUSE=""
RDEPEND="dev-lang/perl
	app-arch/tar"

src_install() {
	dobin furball
	doman furball.1
	dodoc README NEWS THANKS
}
