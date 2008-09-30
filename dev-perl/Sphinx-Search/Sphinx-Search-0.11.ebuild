# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sphinx-Search/Sphinx-Search-0.11.ebuild,v 1.2 2008/09/30 06:30:37 robbat2 Exp $

MODULE_AUTHOR="JJSCHUTZ"
inherit perl-module

DESCRIPTION="Perl API client for Sphinx search engine"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

DEPEND="dev-perl/File-SearchPath
	dev-perl/Path-Class
	dev-perl/DBI
	dev-lang/perl"

pkg_postinst() {
	ewarn "You must connect to a Sphinx searchd of 0.9.8_rc1 or newer"
}
