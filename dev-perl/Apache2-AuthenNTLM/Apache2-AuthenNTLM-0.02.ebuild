# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache2-AuthenNTLM/Apache2-AuthenNTLM-0.02.ebuild,v 1.2 2006/12/10 13:09:30 yuval Exp $

inherit perl-module

DESCRIPTION="Apache2::AuthenNTLM - Perform Microsoft NTLM and Basic User Authentication"
HOMEPAGE="http://search.cpan.org/~speeves/Apache2-AuthenNTLM-${PV}/"
SRC_URI="mirror://cpan/authors/id/S/SP/SPEEVES/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl
	virtual/perl-MIME-Base64
	>=www-apache/mod_perl-2"
RDEPEND="${DEPEND}"
