# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/String-RewritePrefix/String-RewritePrefix-0.006.ebuild,v 1.2 2012/06/16 20:06:08 flameeyes Exp $

EAPI="4"

MODULE_AUTHOR="RJBS"

inherit perl-module

SRC_TEST="do"

DESCRIPTION="rewrite strings based on a set of known prefixes"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-perl/Sub-Exporter-0.982.0"
DEPEND="${RDEPEND}"
