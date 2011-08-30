# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Hash-Merge/Hash-Merge-0.120.0.ebuild,v 1.1 2011/08/30 13:40:54 tove Exp $

EAPI=4

MODULE_AUTHOR=DMUEY
MODULE_VERSION=0.12
inherit perl-module

DESCRIPTION="Merges arbitrarily deep hashes into a single hash"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~ppc-macos ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/Clone"
DEPEND="${RDEPEND}"

SRC_TEST=do
