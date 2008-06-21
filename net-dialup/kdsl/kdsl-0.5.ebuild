# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/kdsl/kdsl-0.5.ebuild,v 1.4 2008/06/21 09:08:09 mrness Exp $

inherit kde

DESCRIPTION="Frontend for pppd with DSL support for PPPoE/PPPoA connections"
HOMEPAGE="http://kdslbroadband.sourceforge.net/"
SRC_URI="mirror://sourceforge/kdslbroadband/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""
RDEPEND="net-dialup/ppp"

need-kde 3
