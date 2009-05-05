# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Clipboard/Clipboard-0.09.ebuild,v 1.1 2009/05/05 21:50:13 vapier Exp $

inherit perl-module

DESCRIPTION="Copy and paste with any OS"
HOMEPAGE="http://search.cpan.org/~king/"
SRC_URI="mirror://cpan/authors/id/K/KI/KING/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/Spiffy"
RDEPEND="${DEPEND}"
