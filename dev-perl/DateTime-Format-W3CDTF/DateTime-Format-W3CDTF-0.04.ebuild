# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-W3CDTF/DateTime-Format-W3CDTF-0.04.ebuild,v 1.8 2007/01/23 01:02:20 kloeri Exp $

inherit perl-module

DESCRIPTION="Parse and format W3CDTF datetime strings"
HOMEPAGE="http://search.cpan.org/~kellan/"
SRC_URI="mirror://cpan/authors/id/K/KE/KELLAN/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/DateTime
		dev-lang/perl"
