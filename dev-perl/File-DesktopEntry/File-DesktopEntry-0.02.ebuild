# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-DesktopEntry/File-DesktopEntry-0.02.ebuild,v 1.2 2006/08/05 03:38:17 mcummings Exp $

inherit perl-module

DESCRIPTION="Object to handle .desktop files"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/P/PA/PARDUS/${PN}/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
