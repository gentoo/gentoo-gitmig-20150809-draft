# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Data-Dumper/Data-Dumper-2.136.0.ebuild,v 1.1 2012/11/17 19:21:02 tove Exp $

EAPI=4

MODULE_AUTHOR=SMUELLER
MODULE_VERSION=2.136
inherit perl-module

DESCRIPTION="Stringified perl data structures, suitable for both printing and eval"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE=""

SRC_TEST="do"
