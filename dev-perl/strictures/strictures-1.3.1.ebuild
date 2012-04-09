# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/strictures/strictures-1.3.1.ebuild,v 1.1 2012/04/09 07:05:14 tove Exp $

EAPI=4

MODULE_AUTHOR=MSTROUT
MODULE_VERSION=1.003001
inherit perl-module

DESCRIPTION="Turn on strict and make all warnings fatal"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x86-solaris"

SRC_TEST=do
