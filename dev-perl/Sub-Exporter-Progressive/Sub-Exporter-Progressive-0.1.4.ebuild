# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sub-Exporter-Progressive/Sub-Exporter-Progressive-0.1.4.ebuild,v 1.1 2012/08/09 17:37:12 tove Exp $

EAPI=4

MODULE_AUTHOR=MSTROUT
MODULE_VERSION=0.001004
inherit perl-module

DESCRIPTION="Only use Sub::Exporter if you need it"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-perl/Sub-Exporter
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.300.0
"

SRC_TEST=do
