# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/tentakel/tentakel-2.1.3.ebuild,v 1.1 2004/11/03 12:57:24 chrb Exp $

inherit distutils

DESCRIPTION="Execute commands on many hosts in parallel"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://tentakel.biskalar.de/"
DEPEND="dev-lang/python"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
S=${WORKDIR}/${P}/py
