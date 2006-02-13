# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-CGI/perl-CGI-3.05.ebuild,v 1.2 2006/02/13 19:01:38 mcummings Exp $

DESCRIPTION="Virtual for CGI"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc alpha mips ia64 ppc64"

IUSE=""
DEPEND=""
RDEPEND="|| ( >=dev-lang/perl-5.8.6 ~perl-core/CGI-${PV} )"

