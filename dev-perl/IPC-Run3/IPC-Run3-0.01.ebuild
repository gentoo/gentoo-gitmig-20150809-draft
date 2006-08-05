# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IPC-Run3/IPC-Run3-0.01.ebuild,v 1.2 2006/08/05 04:49:53 mcummings Exp $

inherit perl-module

DESCRIPTION="Run a subprocess in batch mode (a la system)"
SRC_URI="mirror://cpan/authors/id/R/RB/RBS/IPC-Run3-0.01.tar.gz"
HOMEPAGE="http://search.cpan.org/~autrijus/VCP-autrijus-snapshot-0.9-20050110/"
IUSE=""
SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64"

SRC_TEST="do"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
