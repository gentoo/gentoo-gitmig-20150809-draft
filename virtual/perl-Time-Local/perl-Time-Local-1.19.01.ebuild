# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Time-Local/perl-Time-Local-1.19.01.ebuild,v 1.3 2009/12/04 12:41:29 fauli Exp $

DESCRIPTION="Virtual for Time-Local"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="|| ( ~dev-lang/perl-5.10.1 ~perl-core/Time-Local-${PV} )"
