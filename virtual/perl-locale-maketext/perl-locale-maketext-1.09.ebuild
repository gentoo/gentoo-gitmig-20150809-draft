# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-locale-maketext/perl-locale-maketext-1.09.ebuild,v 1.3 2007/07/11 05:04:22 mr_bones_ Exp $

DESCRIPTION="Virtual for locale-maketext"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc s390 sparc x86"

IUSE=""
DEPEND=""
RDEPEND="|| ( >=dev-lang/perl-5.8.7 ~perl-core/locale-maketext-${PV} )"
