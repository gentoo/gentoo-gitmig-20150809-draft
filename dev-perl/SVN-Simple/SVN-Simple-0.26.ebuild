# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SVN-Simple/SVN-Simple-0.26.ebuild,v 1.1 2004/11/27 06:11:36 pclouds Exp $

inherit perl-module

DESCRIPTION="SVN::Simple::Edit - Simple interface to SVN::Delta::Editor"
SRC_URI="http://www.cpan.org/authors/id/C/CL/CLKAO/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/C/CL/CLKAO/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86"
IUSE=""

DEPEND="${DEPEND}
	>=dev-util/subversion-0.31"

pkg_setup() {
	if ! perl -MSVN::Core < /dev/null 2> /dev/null
	then
		eerror "You need subversion-0.31+ compiled with Perl bindings."
		eerror "USE=\"perl\" emerge subversion"
		die "Need Subversion compiled with Perl bindings."
	fi
}
