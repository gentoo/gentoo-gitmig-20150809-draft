# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/XSLoader/XSLoader-0.10.ebuild,v 1.2 2010/11/18 11:11:45 maekke Exp $

EAPI=2

MODULE_AUTHOR=SAPER
inherit perl-module

DESCRIPTION="Dynamically load C libraries into Perl code"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

PATCHES=( "${FILESDIR}"/91152fc1_rt54132_version081.patch )
SRC_TEST=do
