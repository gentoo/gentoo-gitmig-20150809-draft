# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SVN-Mirror/SVN-Mirror-0.50.ebuild,v 1.1 2004/11/27 06:15:03 pclouds Exp $

inherit perl-module

DESCRIPTION="SVN::Mirror - Mirror remote repositories to local subversion repository"
SRC_URI="http://www.cpan.org/authors/id/C/CL/CLKAO/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/C/CL/CLKAO/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86"
IUSE=""

DEPEND="${DEPEND}
	>=dev-util/subversion-1.0.4
	dev-perl/URI
	dev-perl/TermReadKey
	dev-perl/SVN-Simple"

pkg_setup() {
	if ! perl -MSVN::Core < /dev/null 2> /dev/null
	then
		eerror "You need subversion-1.0.4+ compiled with Perl bindings."
		eerror "USE=\"perl\" emerge subversion"
		die "Need Subversion compiled with Perl bindings."
	fi
}
