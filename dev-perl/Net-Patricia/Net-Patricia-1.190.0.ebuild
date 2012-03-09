# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Patricia/Net-Patricia-1.190.0.ebuild,v 1.3 2012/03/09 09:03:47 phajdan.jr Exp $

EAPI=4

MODULE_AUTHOR=PHILIPP
MODULE_VERSION=1.19
inherit perl-module

DESCRIPTION="Patricia Trie perl module for fast IP address lookups"

LICENSE="|| ( GPL-2 GPL-3 )" # GPL-2+
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~sparc x86"
IUSE="ipv6"

RDEPEND="dev-perl/Net-CIDR-Lite
	ipv6? ( dev-perl/Socket6 )"
DEPEND="${RDEPEND}"

#SRC_TEST="do"
