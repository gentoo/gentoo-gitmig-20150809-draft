# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/OpenCA-CRL/OpenCA-CRL-0.7.61-r1.ebuild,v 1.10 2006/12/11 11:47:56 yuval Exp $

inherit perl-module

DESCRIPTION="The perl OpenCA::CRL Module"
SRC_URI="http://www.cpan.org/authors/id/M/MA/MADWOLF/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~madwolf/${P}/CRL.pm"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

export OPTIMIZE="${CFLAGS}"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
