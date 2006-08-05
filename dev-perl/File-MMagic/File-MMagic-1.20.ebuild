# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-MMagic/File-MMagic-1.20.ebuild,v 1.12 2006/08/05 03:41:50 mcummings Exp $

inherit perl-module

DESCRIPTION="The Perl Image-Info Module"
SRC_URI="mirror://cpan/authors/id/K/KN/KNOK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/File/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
