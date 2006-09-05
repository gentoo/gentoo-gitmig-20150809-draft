# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Sys-Syslog/Sys-Syslog-0.17.ebuild,v 1.5 2006/09/05 05:34:41 kumba Exp $

inherit perl-module

DESCRIPTION="Provides same functionality as BSD syslog"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/S/SA/SAPER/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

# Tests disabled - they attempt to verify on the live system
#SRC_TEST="do"

DEPEND="dev-lang/perl"
