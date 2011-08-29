# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Telnet/Net-Telnet-3.30.0.ebuild,v 1.1 2011/08/29 11:29:30 tove Exp $

EAPI=4

MODULE_AUTHOR=JROGERS
MODULE_VERSION=3.03
inherit perl-module

DESCRIPTION="A Telnet Perl Module"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND=">=virtual/perl-libnet-1.0703"
DEPEND="${RDEPEND}"
