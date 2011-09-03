# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/TheSchwartz/TheSchwartz-1.100.0.ebuild,v 1.2 2011/09/03 21:05:15 tove Exp $

EAPI=4

MODULE_AUTHOR=SIXAPART
MODULE_VERSION=1.10
inherit perl-module

DESCRIPTION="Reliable job queue"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=dev-perl/Data-ObjectDriver-0.06"
DEPEND="${RDEPEND}"

SRC_TEST="do"
