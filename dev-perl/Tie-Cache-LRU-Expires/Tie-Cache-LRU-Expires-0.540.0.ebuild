# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tie-Cache-LRU-Expires/Tie-Cache-LRU-Expires-0.540.0.ebuild,v 1.1 2011/08/28 11:49:17 tove Exp $

EAPI=4

MODULE_AUTHOR=OESTERHOL
MODULE_VERSION=0.54
inherit perl-module

DESCRIPTION="Extends Tie::Cache::LRU with expiring"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/Tie-Cache-LRU"
DEPEND="${RDEPEND}"

SRC_TEST=do
