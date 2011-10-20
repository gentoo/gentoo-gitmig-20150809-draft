# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AnyEvent/AnyEvent-6.100.0.ebuild,v 1.1 2011/10/20 19:32:03 tove Exp $

EAPI=4

MODULE_AUTHOR=MLEHMANN
MODULE_VERSION=6.1
inherit perl-module

DESCRIPTION="provide framework for multiple event loops"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/Event"
DEPEND=""

SRC_TEST="do"
