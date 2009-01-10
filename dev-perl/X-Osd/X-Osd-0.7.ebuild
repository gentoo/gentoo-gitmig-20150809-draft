# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/X-Osd/X-Osd-0.7.ebuild,v 1.1 2009/01/10 12:57:38 beandog Exp $

inherit perl-module

DESCRIPTION="Perl glue to libxosd (X OnScreen Display)"
HOMEPAGE="http://search.cpan.org/search?query=X-Osd&mode=dist"
SRC_URI="mirror://cpan/authors/id/G/GO/GOZER/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"
DEPEND="x11-libs/xosd"
