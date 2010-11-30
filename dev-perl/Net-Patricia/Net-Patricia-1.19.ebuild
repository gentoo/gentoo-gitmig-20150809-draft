# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Patricia/Net-Patricia-1.19.ebuild,v 1.1 2010/11/30 19:41:53 tove Exp $

EAPI=3

MODULE_AUTHOR=PHILIPP
inherit perl-module

DESCRIPTION="Patricia Trie perl module for fast IP address lookups"

LICENSE="|| ( GPL-2 GPL-3 )" # GPL-2+
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="ipv6"

RDEPEND="dev-perl/Net-CIDR-Lite
	ipv6? ( dev-perl/Socket6 )"
DEPEND="${RDEPEND}"

#SRC_TEST="do"
