# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Dump-Streamer/Data-Dump-Streamer-2.230.ebuild,v 1.1 2011/01/19 16:53:21 tove Exp $

EAPI=3

MODULE_AUTHOR=JJORE
MODULE_VERSION=2.23
inherit perl-module

DESCRIPTION="Accurately serialize a data structure as Perl code"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-perl/B-Utils-0.07"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
