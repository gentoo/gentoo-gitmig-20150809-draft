# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tree-DAG_Node/Tree-DAG_Node-1.05.ebuild,v 1.4 2006/04/05 10:36:32 mcummings Exp $

inherit perl-module

DESCRIPTION="(super)class for representing nodes in a tree"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/S/SB/SBURKE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ia64 ~ppc ~sparc ~x86 ~amd64"
IUSE=""

SRC_TEST="do"
