# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Log-Agent/Log-Agent-0.307.ebuild,v 1.16 2006/10/20 19:51:25 kloeri Exp $

inherit perl-module

DESCRIPTION="A general logging framework"
SRC_URI="mirror://cpan/authors/id/M/MR/MROGASKI/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/M/MR/MROGASKI/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""


DEPEND="dev-lang/perl"
