# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-GlobalDestruction/Devel-GlobalDestruction-0.40.0.ebuild,v 1.5 2012/03/08 12:34:03 phajdan.jr Exp $

EAPI=4

MODULE_AUTHOR=FLORA
MODULE_VERSION=0.04
inherit perl-module

DESCRIPTION="Expose PL_dirty, the flag which marks global destruction"

SLOT="0"
KEYWORDS="amd64 ppc x86 ~x64-macos"
IUSE=""

RDEPEND="dev-perl/Sub-Exporter"
DEPEND="${RDEPEND}"

SRC_TEST=do
