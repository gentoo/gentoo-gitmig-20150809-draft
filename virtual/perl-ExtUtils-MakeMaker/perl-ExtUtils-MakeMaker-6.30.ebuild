# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-ExtUtils-MakeMaker/perl-ExtUtils-MakeMaker-6.30.ebuild,v 1.7 2006/05/25 18:11:47 gmsoft Exp $

DESCRIPTION="Virtual for ExtUtils-MakeMaker"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~s390 sparc x86"

IUSE=""
DEPEND=""
RDEPEND="|| ( ~dev-lang/perl-5.8.8 ~perl-core/ExtUtils-MakeMaker-${PV} )"

