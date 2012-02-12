# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Schedule-At/Schedule-At-1.10.ebuild,v 1.4 2012/02/12 15:09:30 armin76 Exp $

EAPI=2

MODULE_AUTHOR=JOSERODR
inherit perl-module

DESCRIPTION="OS independent interface to the Unix 'at' command"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="sys-process/at"
DEPEND="${RDEPEND}"

#SRC_TEST="do"
