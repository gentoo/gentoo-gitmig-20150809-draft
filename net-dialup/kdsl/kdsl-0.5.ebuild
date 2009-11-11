# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/kdsl/kdsl-0.5.ebuild,v 1.5 2009/11/11 12:45:09 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde

DESCRIPTION="Frontend for pppd with DSL support for PPPoE/PPPoA connections"
HOMEPAGE="http://kdslbroadband.sourceforge.net/"
SRC_URI="mirror://sourceforge/kdslbroadband/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="net-dialup/ppp"

need-kde 3.5
