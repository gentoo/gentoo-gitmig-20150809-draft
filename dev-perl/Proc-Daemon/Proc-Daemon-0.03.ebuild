# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Proc-Daemon/Proc-Daemon-0.03.ebuild,v 1.18 2007/07/10 23:33:26 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Perl Proc-Daemon -  Run Perl program as a daemon process"
HOMEPAGE="http://search.cpan.org/~ehood/"
SRC_URI="mirror://cpan/authors/id/E/EH/EHOOD/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
