# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/cdk-perl/cdk-perl-20031210.ebuild,v 1.13 2007/03/13 16:00:50 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl extension for Cdk"
HOMEPAGE="http://dickey.his.com/cdk/cdk.html"
SRC_URI="ftp://invisible-island.net/cdk/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc s390 sparc x86"
IUSE=""

DEPEND=">=dev-libs/cdk-4.9.10.20031210
	dev-lang/perl"

mydoc="MANIFEST"

src_unpack() {
	unpack ${P}.tgz
	cd "${S}"
	sed -i -e "s:/usr/local:/usr:g" Makefile.PL
}
