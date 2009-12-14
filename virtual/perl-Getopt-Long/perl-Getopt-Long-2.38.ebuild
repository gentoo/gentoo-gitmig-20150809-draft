# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Getopt-Long/perl-Getopt-Long-2.38.ebuild,v 1.8 2009/12/14 19:05:25 armin76 Exp $

DESCRIPTION="Virtual for Getopt-Long"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ~ppc ppc64 ~s390 ~sh sparc x86"
IUSE=""

RDEPEND="|| ( ~dev-lang/perl-5.10.1 ~perl-core/Getopt-Long-${PV} )"
