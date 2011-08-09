# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-HTTP/Net-HTTP-6.10.0.ebuild,v 1.6 2011/08/09 16:09:19 xarthisius Exp $

EAPI=4

MODULE_AUTHOR=GAAS
MODULE_VERSION=6.01
inherit perl-module

DESCRIPTION="Low-level HTTP connection (client)"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="
	!<dev-perl/libwww-perl-6
	virtual/perl-Compress-Raw-Zlib
	virtual/perl-IO
	virtual/perl-IO-Compress
"
DEPEND="${RDEPEND}"

SRC_TEST=do
