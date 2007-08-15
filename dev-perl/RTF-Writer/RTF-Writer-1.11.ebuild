# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/RTF-Writer/RTF-Writer-1.11.ebuild,v 1.1 2007/08/15 18:16:30 ian Exp $

inherit perl-module

DESCRIPTION="RTF::Writer - for generating documents in Rich Text Format"
HOMEPAGE="http://search.cpan.org/~sburke/${P}"
SRC_URI="mirror://cpan/authors/id/S/SB/SBURKE/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86"
IUSE="test"
SRC_TEST="do"

DEPEND="dev-lang/perl
		dev-perl/ImageSize
		test? ( perl-core/Test-Harness )"
