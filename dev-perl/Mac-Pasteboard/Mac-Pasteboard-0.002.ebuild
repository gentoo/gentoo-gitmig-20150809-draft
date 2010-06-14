# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mac-Pasteboard/Mac-Pasteboard-0.002.ebuild,v 1.2 2010/06/14 17:18:25 grobian Exp $

inherit perl-module

DESCRIPTION="Manipulate Mac OS X clipboards/pasteboards."
SRC_URI="mirror://cpan/authors/id/W/WY/WYANT/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~wyant/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

DEPEND="dev-lang/perl"
