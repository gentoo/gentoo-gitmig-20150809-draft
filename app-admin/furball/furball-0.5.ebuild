# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/furball/furball-0.5.ebuild,v 1.5 2002/07/17 20:43:16 drobbins Exp $

S=${WORKDIR}/${P}

DESCRIPTION="A handy backup script utilizing tar."
SRC_URI="http://www.claws-and-paws.com/software/furball/${P}.tgz"
SLOT="0"
HOMEPAGE="http://www.claws-and-paws.com/software/furball/index.shtml"
LICENSE="GPL-2"

RDEPEND="sys-devel/perl
	sys-apps/tar"

src_install() {

	cd ${S}

	dobin furball
	doman furball.1
	dodoc README NEWS THANKS

}
