# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AnyEvent/AnyEvent-7.40.0.ebuild,v 1.6 2014/07/29 21:28:29 zlogene Exp $

EAPI=4

MODULE_AUTHOR=MLEHMANN
MODULE_VERSION=7.04
inherit perl-module

DESCRIPTION="Provides a uniform interface to various event loops"

SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sparc x86 ~x86-solaris"
IUSE=""

SRC_TEST="do"
