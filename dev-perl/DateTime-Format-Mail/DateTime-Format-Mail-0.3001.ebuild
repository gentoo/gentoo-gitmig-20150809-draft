# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-Mail/DateTime-Format-Mail-0.3001.ebuild,v 1.4 2009/12/23 17:59:59 grobian Exp $

inherit perl-module

DESCRIPTION="Convert between DateTime and RFC2822/822 formats"
HOMEPAGE="http://search.cpan.org/~drolsky/"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ~ppc ~ppc64 sparc x86 ~x86-fbsd ~x86-solaris"
IUSE=""

SRC_TEST="do"

RDEPEND=">=dev-perl/Params-Validate-0.67
		>=dev-perl/DateTime-0.17
		dev-lang/perl"
DEPEND="${RDEPEND}
		virtual/perl-Module-Build"
