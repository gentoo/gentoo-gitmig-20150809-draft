# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/OpenCA-OpenSSL/OpenCA-OpenSSL-0.9.91.ebuild,v 1.16 2006/12/11 11:44:47 yuval Exp $

inherit perl-module

DESCRIPTION="The perl OpenCA::SSL Module"
SRC_URI="mirror://cpan/authors/id/M/MA/MADWOLF/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~madwolf/${P}/OpenSSL.pod"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc s390 sparc x86"
IUSE=""

export OPTIMIZE="${CFLAGS}"

DEPEND="dev-perl/X500-DN
	dev-libs/openssl
	dev-lang/perl"
RDEPEND="${DEPEND}"


