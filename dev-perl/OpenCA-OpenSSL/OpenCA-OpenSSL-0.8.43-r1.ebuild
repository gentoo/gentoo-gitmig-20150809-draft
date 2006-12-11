# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/OpenCA-OpenSSL/OpenCA-OpenSSL-0.8.43-r1.ebuild,v 1.12 2006/12/11 11:44:47 yuval Exp $

inherit perl-module

DESCRIPTION="The perl OpenCA::SSL Module"
SRC_URI="mirror://cpan/authors/id/M/MA/MADWOLF/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~madwolf/${P}/OpenSSL.pm"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha s390"
IUSE=""

export OPTIMIZE="${CFLAGS}"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
