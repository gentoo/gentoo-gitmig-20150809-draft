# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sys-Hostname-Long/Sys-Hostname-Long-1.4.ebuild,v 1.15 2010/01/11 20:20:28 grobian Exp $

inherit perl-module

DESCRIPTION="Try every conceivable way to get full hostname"
SRC_URI="mirror://cpan/authors/id/S/SC/SCOTT/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~scott/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

mydoc="TODO"

DEPEND="dev-lang/perl"
