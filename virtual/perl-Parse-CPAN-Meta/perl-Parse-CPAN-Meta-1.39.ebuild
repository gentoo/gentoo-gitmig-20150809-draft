# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Parse-CPAN-Meta/perl-Parse-CPAN-Meta-1.39.ebuild,v 1.3 2009/08/25 10:56:46 tove Exp $

DESCRIPTION="Virtual for Parse-CPAN-Meta"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( ~dev-lang/perl-5.10.1 ~perl-core/Parse-CPAN-Meta-${PV} )"
