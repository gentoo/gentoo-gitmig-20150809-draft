# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GraphViz/GraphViz-2.02.ebuild,v 1.5 2008/11/18 15:02:25 tove Exp $

inherit perl-module eutils

DESCRIPTION="GraphViz - Interface to the GraphViz graphing tool"
HOMEPAGE="http://search.cpan.org/~lbrocard/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/L/LB/LBROCARD/${P}.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl
	>=virtual/perl-Module-Build-0.28
	media-gfx/graphviz
	dev-perl/IPC-Run"
