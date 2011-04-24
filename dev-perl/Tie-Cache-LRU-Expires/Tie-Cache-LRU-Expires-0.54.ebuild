# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tie-Cache-LRU-Expires/Tie-Cache-LRU-Expires-0.54.ebuild,v 1.2 2011/04/24 16:02:50 grobian Exp $

EAPI=2

MODULE_AUTHOR=OESTERHOL
inherit perl-module

DESCRIPTION="Extends Tie::Cache::LRU with expiring"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/Tie-Cache-LRU"
DEPEND="${RDEPEND}"

SRC_TEST=do
