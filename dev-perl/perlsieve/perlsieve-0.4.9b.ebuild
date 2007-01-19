# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perlsieve/perlsieve-0.4.9b.ebuild,v 1.17 2007/01/19 15:24:30 mcummings Exp $

inherit perl-module

S=${WORKDIR}/perlsieve-0.4.9
DESCRIPTION="Access Sieve services"
HOMEPAGE="http://sourceforge.net/projects/websieve/"
SRC_URI="http://lists.opensoftwareservices.com/websieve/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc s390 sparc x86"
IUSE=""


DEPEND="dev-lang/perl"
