# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/cdk-perl/cdk-perl-20010421.ebuild,v 1.12 2004/07/14 16:46:34 agriffis Exp $

inherit perl-module

DESCRIPTION="Perl extension for Cdk."
SRC_URI="ftp://invisible-island.net/cdk/${P}.tgz"
HOMEPAGE="http://dickey.his.com/cdk/cdk.html"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 amd64 sparc alpha"
IUSE=""

DEPEND="${DEPEND}
	>=dev-libs/cdk-4.9.10.20020430"

mydoc="BUGS FILES NOTES CHANGES"

src_unpack()
{
	unpack ${P}.tgz
	cd ${S}
	cp Makefile.PL Makefile.PL.orig
	sed -e "s:/usr/local:/usr:g" Makefile.PL.orig > Makefile.PL
}
