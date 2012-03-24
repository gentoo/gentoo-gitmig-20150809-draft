# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Encode-HanConvert/Encode-HanConvert-0.33.ebuild,v 1.5 2012/03/24 20:06:25 armin76 Exp $

inherit perl-module

DESCRIPTION="Traditional and Simplified Chinese mappings"
HOMEPAGE="http://search.cpan.org/~kcwu/"
SRC_URI="mirror://cpan/authors/id/K/KC/KCWU/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

SRC_TEST="do"

DEPEND=">dev-lang/perl-5.6.1"
