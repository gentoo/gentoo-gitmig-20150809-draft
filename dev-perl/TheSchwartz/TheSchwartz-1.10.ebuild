# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/TheSchwartz/TheSchwartz-1.10.ebuild,v 1.5 2010/12/05 17:12:20 armin76 Exp $

EAPI=2

MODULE_AUTHOR=SIXAPART
inherit perl-module

DESCRIPTION="Reliable job queue"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND=">=dev-perl/Data-ObjectDriver-0.06"
DEPEND="${RDEPEND}"

SRC_TEST="do"
