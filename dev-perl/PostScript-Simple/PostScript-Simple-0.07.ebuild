# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PostScript-Simple/PostScript-Simple-0.07.ebuild,v 1.7 2006/08/18 01:10:44 mcummings Exp $

inherit perl-module

DESCRIPTION="Allows you to have a simple method of writing PostScript files from Perl"
HOMEPAGE="http://search.cpan.org/~sburke/${P}/"
SRC_URI="mirror://cpan/authors/id/M/MC/MCNEWTON/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-1 GPL-2 )"
SLOT="0"
KEYWORDS="amd64 hppa ia64 ~ppc sparc ~x86"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
