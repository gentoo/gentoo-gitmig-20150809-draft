# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/RTF-Writer/RTF-Writer-1.11.ebuild,v 1.4 2010/10/24 09:14:26 tove Exp $

EAPI=3

MODULE_AUTHOR=SBURKE
inherit perl-module

DESCRIPTION="RTF::Writer - for generating documents in Rich Text Format"

SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="dev-perl/ImageSize"
DEPEND="${RDEPEND}"

SRC_TEST="do"
