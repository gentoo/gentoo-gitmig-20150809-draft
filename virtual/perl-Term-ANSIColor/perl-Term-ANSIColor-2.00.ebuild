# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Term-ANSIColor/perl-Term-ANSIColor-2.00.ebuild,v 1.6 2009/12/07 20:12:14 jer Exp $

DESCRIPTION="Color screen output using ANSI escape sequences."
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""

RDEPEND="|| ( ~dev-lang/perl-5.10.1 ~perl-core/Term-ANSIColor-${PV} )"
