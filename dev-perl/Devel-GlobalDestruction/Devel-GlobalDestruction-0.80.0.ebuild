# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-GlobalDestruction/Devel-GlobalDestruction-0.80.0.ebuild,v 1.1 2012/08/06 11:22:33 tove Exp $

EAPI=4

MODULE_AUTHOR=FLORA
MODULE_VERSION=0.08
inherit perl-module

DESCRIPTION="Expose PL_dirty, the flag which marks global destruction"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-perl/Sub-Exporter-Progressive-0.1.2"
DEPEND="${RDEPEND}"

SRC_TEST=do
