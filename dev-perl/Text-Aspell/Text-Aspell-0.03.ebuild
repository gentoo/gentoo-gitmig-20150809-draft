# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Aspell/Text-Aspell-0.03.ebuild,v 1.11 2006/07/05 11:13:05 ian Exp $

inherit perl-module

DESCRIPTION="Perl interface to the GNU Aspell Library"
SRC_URI="mirror://cpan/authors/id/H/HA/HANK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/H/HA/HANK/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 alpha ~hppa ~mips ppc sparc"
IUSE=""

DEPEND="app-text/aspell"
RDEPEND="${DEPEND}"
