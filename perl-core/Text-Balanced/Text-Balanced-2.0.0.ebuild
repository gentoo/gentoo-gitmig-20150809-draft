# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Text-Balanced/Text-Balanced-2.0.0.ebuild,v 1.7 2007/04/04 22:59:50 ferdy Exp $

inherit perl-module

MY_P="${PN}-v${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Extract balanced-delimiter substrings"
HOMEPAGE="http://search.cpan.org/~dconway"
SRC_URI="mirror://cpan/authors/id/D/DC/DCONWAY/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/version
	>=dev-perl/module-build-0.28"
