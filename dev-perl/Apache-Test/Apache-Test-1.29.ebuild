# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-Test/Apache-Test-1.29.ebuild,v 1.10 2008/05/13 14:25:03 jer Exp $

inherit depend.apache perl-module

DESCRIPTION="Test.pm wrapper with helpers for testing Apache"
SRC_URI="mirror://cpan/authors/id/P/PG/PGOLLUCCI/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/Apache/"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ppc ppc64 sparc x86"
SRC_TEST="skip"

DEPEND="dev-lang/perl"

need_apache

src_install() {
	# This is to avoid conflicts with a deprecated Apache::Test stepping
	# in and causing problems/install errors
	if [ -f  "${S}"/.mypacklist ];
	then
		rm -f "${S}"/.mypacklist
	fi
	perl-module_src_install
}
