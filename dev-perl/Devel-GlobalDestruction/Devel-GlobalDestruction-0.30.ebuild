# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-GlobalDestruction/Devel-GlobalDestruction-0.30.ebuild,v 1.1 2011/01/12 21:13:34 tove Exp $

EAPI=3

MODULE_AUTHOR=FLORA
MODULE_VERSION=0.03
inherit perl-module

DESCRIPTION="Expose PL_dirty, the flag which marks global destruction"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-perl/Sub-Exporter
	dev-perl/Scope-Guard"
DEPEND="${RDEPEND}"

SRC_TEST=do
