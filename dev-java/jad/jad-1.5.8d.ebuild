# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jad/jad-1.5.8d.ebuild,v 1.7 2003/08/24 03:00:38 strider Exp $

S=${WORKDIR}
DESCRIPTION="Jad - the fast JAva Decompiler"
HOMEPAGE="http://kpdus.tripod.com/jad.html"
SRC_URI="http://kpdus.tripod.com/jad/linux/jadls158.zip"

DEPEND=">=app-arch/unzip-5.50-r1"
KEYWORDS="x86"
SLOT="0"
LICENSE="freedist"

src_install () {
	dobin jad
	dodoc Readme.txt
}
