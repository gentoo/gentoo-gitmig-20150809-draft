# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/indirect/indirect-0.240.0.ebuild,v 1.1 2011/07/18 10:45:01 tove Exp $

EAPI=4

MODULE_AUTHOR=VPIT
MODULE_VERSION=0.24
inherit perl-module

DESCRIPTION="Lexically warn about using the indirect object syntax"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_TEST=do
