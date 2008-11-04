# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Term-ANSIColor/perl-Term-ANSIColor-1.12.ebuild,v 1.3 2008/11/04 10:07:49 vapier Exp $

DESCRIPTION="Color screen output using ANSI escape sequences."
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ~ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"

IUSE=""
DEPEND=""

RDEPEND="|| ( ~dev-lang/perl-5.10.0 ~perl-core/Term-ANSIColor-${PV} )"
