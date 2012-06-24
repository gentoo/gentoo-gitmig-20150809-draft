# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PathTools/PathTools-3.33.ebuild,v 1.1 2012/06/24 00:09:20 cardoe Exp $

EAPI=4

MODULE_AUTHOR="SMUELLER"

inherit perl-module

DESCRIPTION="Portably perform operations on file names"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}"

SRC_TEST="do"
