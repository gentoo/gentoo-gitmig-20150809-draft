# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/cdk-perl/cdk-perl-20010421.ebuild,v 1.2 2002/07/25 04:13:27 seemant Exp $


# Inherit the perl-module.eclass functions
inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"

DESCRIPTION="Perl extension for Cdk."
SRC_URI="ftp://invisible-island.net/cdk/${P}.tgz"
SLOT="0"
HOMEPAGE="http://dickey.his.com/cdk/cdk.html"

SLOT="0"
LICENSE="BSD"
SLOT="0"
DEPEND="${DEPEND} >=dev-libs/cdk-4.9.10.20020430"

mydoc="BUGS FILES NOTES CHANGES"

src_unpack()
{
	unpack ${P}.tgz
	cd ${S}
	cp Makefile.PL Makefile.PL.orig
	sed -e "s:/usr/local:/usr:g" Makefile.PL.orig > Makefile.PL
}
