# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Math-BigInt/perl-Math-BigInt-1.89.ebuild,v 1.7 2009/12/07 23:02:54 maekke Exp $

DESCRIPTION="Virtual for Math-BigInt"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ~ppc ~s390 ~sh ~sparc x86"

IUSE=""
DEPEND=""
RDEPEND="|| ( ~dev-lang/perl-5.10.1 ~perl-core/Math-BigInt-${PV} )"
