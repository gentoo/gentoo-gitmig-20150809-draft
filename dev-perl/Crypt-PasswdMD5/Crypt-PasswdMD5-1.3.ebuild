# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-PasswdMD5/Crypt-PasswdMD5-1.3.ebuild,v 1.1 2006/10/20 16:33:10 mcummings Exp $

inherit perl-module

DESCRIPTION="Provides interoperable MD5-based crypt() functions"
HOMEPAGE="http://search.cpan.org/~luismunoz/"
SRC_URI="mirror://cpan/authors/id/L/LU/LUISMUNOZ/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
