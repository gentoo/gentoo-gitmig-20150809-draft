# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GDTextUtil/GDTextUtil-0.86.ebuild,v 1.20 2010/07/19 21:48:54 maekke Exp $

EAPI=3

MODULE_AUTHOR=MVERB
inherit perl-module

DESCRIPTION="Text utilities for use with GD"

SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/GD"
DEPEND="${RDEPEND}"
