# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sys-Syscall/Sys-Syscall-0.23.ebuild,v 1.2 2011/09/04 10:11:56 maekke Exp $

inherit perl-module

DESCRIPTION="access system calls that Perl doesn't normally provide access to"
HOMEPAGE="http://search.cpan.org/search?query=Sys-Syscall&mode=dist"
SRC_URI="mirror://cpan/authors/id/B/BR/BRADFITZ/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc x86"

DEPEND="dev-lang/perl"
mydoc="CHANGES"
SRC_TEST="do"
