# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/strictures/strictures-1.2.2.ebuild,v 1.2 2011/06/14 17:17:52 grobian Exp $

EAPI=4

MODULE_AUTHOR=MSTROUT
MODULE_VERSION=1.002002
inherit perl-module

DESCRIPTION="Turn on strict and make all warnings fatal"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x86-solaris"

SRC_TEST=do
