# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Rcs/Rcs-1.05.ebuild,v 1.2 2010/12/08 17:41:08 chainsaw Exp $

EAPI="2"

MODULE_AUTHOR=CFRETER
inherit perl-module

DESCRIPTION="Perl bindings for Revision Control System"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-vcs/rcs"
DEPEND="${RDEPEND}"
