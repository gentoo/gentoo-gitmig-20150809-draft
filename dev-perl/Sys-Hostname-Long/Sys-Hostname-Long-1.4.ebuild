# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sys-Hostname-Long/Sys-Hostname-Long-1.4.ebuild,v 1.9 2006/08/17 22:04:24 mcummings Exp $

inherit perl-module

DESCRIPTION="Try every conceivable way to get full hostname"
SRC_URI="mirror://cpan/authors/id/S/SC/SCOTT/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~scott/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 hppa ia64 ~ppc ~ppc64 sparc ~x86"
IUSE=""

mydoc="TODO"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
