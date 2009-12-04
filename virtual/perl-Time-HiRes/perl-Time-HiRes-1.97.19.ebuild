# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Time-HiRes/perl-Time-HiRes-1.97.19.ebuild,v 1.3 2009/12/04 12:40:10 fauli Exp $

DESCRIPTION="Virtual for Time-HiRes"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( ~dev-lang/perl-5.10.1 ~perl-core/Time-HiRes-${PV} )"
