# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jad-bin/jad-bin-1.5.8e.ebuild,v 1.8 2008/12/21 16:17:03 serkan Exp $

DESCRIPTION="Jad - The fast JAva Decompiler"
HOMEPAGE="http://www.kpdus.com/jad.html"
SRC_URI="http://www.kpdus.com/jad/linux/jadls158.zip"
DEPEND="app-arch/unzip"
RDEPEND=""
KEYWORDS="x86 amd64 -ppc"
SLOT="0"
LICENSE="freedist"
IUSE=""

S=${WORKDIR}

RESTRICT="strip"

src_install() {
	into /opt
	dobin jad || die "dobin failed"
	dodoc Readme.txt || die "dodoc failed"
}
