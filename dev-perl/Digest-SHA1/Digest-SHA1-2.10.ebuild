# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-SHA1/Digest-SHA1-2.10.ebuild,v 1.5 2004/10/16 23:57:21 rac Exp $

inherit perl-module

DESCRIPTION=" NIST SHA message digest algorithm"
SRC_URI="http://www.perl.com/CPAN/authors/id/GAAS/${P}.tar.gz"
HOMEPAGE="http://cpan.pair.com/modules/by-category/14_Security_and_Encryption/Digest/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa ~mips ~ia64 ppc64"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/digest-base"
