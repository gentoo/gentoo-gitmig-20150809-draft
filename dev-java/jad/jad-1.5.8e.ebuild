# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jad/jad-1.5.8e.ebuild,v 1.1 2004/03/06 23:56:59 zx Exp $

DESCRIPTION="Jad - the fast JAva Decompiler"
HOMEPAGE="http://www.kpdus.com/jad"
SRC_URI="http://www.kpdus.com/jad/linux/jadls158.zip"
DEPEND=""
KEYWORDS="~x86"
SLOT="0"
LICENSE="freedist"
IUSE=""

S=${WORKDIR}

src_install () {
	into /opt
	dobin jad
	dodoc Readme.txt
}
