# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Scalar-List-Utils/perl-Scalar-List-Utils-1.18.ebuild,v 1.12 2007/12/29 10:13:55 welp Exp $

DESCRIPTION="Virtual for Scalar-List-Utils"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( ~dev-lang/perl-5.8.8 ~perl-core/Scalar-List-Utils-${PV} )"
