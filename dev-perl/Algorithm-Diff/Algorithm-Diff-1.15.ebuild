# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Algorithm-Diff/Algorithm-Diff-1.15.ebuild,v 1.14 2006/08/04 22:12:37 mcummings Exp $

inherit perl-module

DESCRIPTION="Algorithm::Diff - Compute intelligent differences between two files / lists"
HOMEPAGE="http://search.cpan.org/~nedkonz/${P}/"
SRC_URI="mirror://cpan/authors/id/N/NE/NEDKONZ/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
IUSE=""
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ppc64 amd64"
DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
