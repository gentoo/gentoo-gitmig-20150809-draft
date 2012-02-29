# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-Date/HTTP-Date-6.0.1.ebuild,v 1.1 2012/02/29 09:02:18 robbat2 Exp $

EAPI=3

MODULE_AUTHOR=GAAS
MODULE_VERSION=${PV/0./0}
inherit perl-module

DESCRIPTION="Date conversion for HTTP date formats"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="
	!<dev-perl/libwww-perl-6
	virtual/perl-Time-Local
"
DEPEND="${RDEPEND}"

SRC_TEST=do
