# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Template-Tiny/Template-Tiny-0.11.ebuild,v 1.1 2010/02/23 15:24:30 tove Exp $

EAPI=2

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="Template Toolkit reimplemented in as little code as possible"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-perl/Capture-Tiny-0.07"
DEPEND="${RDEPEND}"

SRC_TEST=do
