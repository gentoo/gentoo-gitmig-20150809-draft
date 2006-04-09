# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-MIME-Base64/perl-MIME-Base64-3.05.ebuild,v 1.3 2006/04/09 17:58:04 vapier Exp $

DESCRIPTION="Virtual for MIME-Base64"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"

IUSE=""
DEPEND=""
RDEPEND="|| ( ~dev-lang/perl-5.8.7 ~perl-core/MIME-Base64-${PV} )"

