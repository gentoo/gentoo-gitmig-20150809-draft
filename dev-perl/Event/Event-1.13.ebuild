# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Event/Event-1.13.ebuild,v 1.2 2009/12/23 18:08:58 grobian Exp $

EAPI=2

MODULE_AUTHOR=JPRIT
inherit perl-module

DESCRIPTION="fast, generic event loop"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-solaris"
IUSE=""

SRC_TEST="do"

mydoc="ANNOUNCE INSTALL TODO Tutorial.pdf"
