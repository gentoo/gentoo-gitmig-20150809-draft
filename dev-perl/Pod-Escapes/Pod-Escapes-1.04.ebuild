# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Pod-Escapes/Pod-Escapes-1.04.ebuild,v 1.22 2008/04/27 20:10:32 aballier Exp $

inherit perl-module

DESCRIPTION="for resolving Pod E<...> sequences"
HOMEPAGE="http://search.cpan.org/~sburke/"
SRC_URI="mirror://cpan/authors/id/S/SB/SBURKE/${P}.tar.gz"

SRC_TEST="do"
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/perl"
