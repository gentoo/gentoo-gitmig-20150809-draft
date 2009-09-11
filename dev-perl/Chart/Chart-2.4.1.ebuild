# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Chart/Chart-2.4.1.ebuild,v 1.7 2009/09/11 18:16:55 tove Exp $

EAPI=2

MODULE_AUTHOR=CHARTGRP
inherit perl-module

DESCRIPTION="The Perl Chart Module"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="test"

RDEPEND=">=dev-perl/GD-1.2"
DEPEND="${RDEPEND}
	test? ( dev-perl/GD[png] )"

SRC_TEST="do"
mydoc="TODO"
