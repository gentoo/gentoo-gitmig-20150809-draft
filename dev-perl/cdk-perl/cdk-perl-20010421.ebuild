# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/cdk-perl/cdk-perl-20010421.ebuild,v 1.7 2002/12/15 10:44:17 bjb Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl extension for Cdk."
SRC_URI="ftp://invisible-island.net/cdk/${P}.tgz"
HOMEPAGE="http://dickey.his.com/cdk/cdk.html"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 sparc alpha"

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
