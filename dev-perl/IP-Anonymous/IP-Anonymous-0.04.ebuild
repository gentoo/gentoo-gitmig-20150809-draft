# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IP-Anonymous/IP-Anonymous-0.04.ebuild,v 1.1 2007/05/23 11:18:01 ian Exp $

inherit perl-module

DESCRIPTION="Perl port of Crypto-PAn to provide anonymous IP addresses"
SRC_URI="mirror://cpan/authors/id/J/JT/JTK/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~jtk/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl
		dev-perl/Crypt-Rijndael"
