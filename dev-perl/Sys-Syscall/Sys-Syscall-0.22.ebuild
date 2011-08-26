# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sys-Syscall/Sys-Syscall-0.22.ebuild,v 1.4 2011/08/26 09:12:35 chainsaw Exp $

inherit perl-module

DESCRIPTION="access system calls that Perl doesn't normally provide access to"
HOMEPAGE="http://search.cpan.org/search?query=Sys-Syscall&mode=dist"
SRC_URI="mirror://cpan/authors/id/B/BR/BRADFITZ/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ~ppc x86"

DEPEND="dev-lang/perl"
mydoc="CHANGES"
SRC_TEST="do"
