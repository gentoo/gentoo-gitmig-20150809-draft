# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Netmask/Net-Netmask-1.9013.ebuild,v 1.3 2006/10/21 00:41:47 mcummings Exp $

inherit perl-module

DESCRIPTION="Parse, manipulate and lookup IP network blocks"
SRC_URI="mirror://cpan/authors/id/M/MU/MUIR/modules/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/MUIR/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha amd64 ~ia64 ~mips ~ppc sparc ~x86"
IUSE=""

mydoc="TODO"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
