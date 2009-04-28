# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IPC-Shareable/IPC-Shareable-0.60.ebuild,v 1.3 2009/04/28 07:30:21 jokey Exp $

inherit perl-module

DESCRIPTION="Tie a variable to shared memory"
HOMEPAGE="http://search.cpan.org/search?query=IPC-Shareable&mode=dist"
SRC_URI="mirror://cpan/authors/id/B/BS/BSUGARS/IPC-Shareable-0.60.tar.gz"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
