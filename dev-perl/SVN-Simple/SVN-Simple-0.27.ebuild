# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SVN-Simple/SVN-Simple-0.27.ebuild,v 1.12 2007/05/05 16:06:53 ian Exp $

inherit perl-module

DESCRIPTION="SVN::Simple::Edit - Simple interface to SVN::Delta::Editor"
SRC_URI="mirror://cpan/authors/id/C/CL/CLKAO/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~clkao/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 ia64 ppc sparc ~x86"
IUSE=""

DEPEND=">=dev-util/subversion-0.31
	dev-lang/perl"

pkg_setup() {
	if ! built_with_use dev-util/subversion perl; then
		eerror "You need >=dev-util/subversion-0.31 compiled with Perl bindings."
		die "Need Subversion compiled with Perl bindings."
	fi
}
