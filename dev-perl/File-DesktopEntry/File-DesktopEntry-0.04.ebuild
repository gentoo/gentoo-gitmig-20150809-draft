# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-DesktopEntry/File-DesktopEntry-0.04.ebuild,v 1.1 2008/04/25 17:04:47 drac Exp $

inherit perl-module

DESCRIPTION="Object to handle .desktop files"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/P/PA/PARDUS/${PN}/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl"
