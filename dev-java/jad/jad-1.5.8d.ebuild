# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jad/jad-1.5.8d.ebuild,v 1.5 2002/10/04 05:10:49 vapier Exp $

S=${WORKDIR}
DESCRIPTION="Jad - the fast JAva Decompiler"
HOMEPAGE="http://kpdus.tripod.com/jad.html"
SRC_URI="http://kpdus.tripod.com/jad/linux/jadls158.zip"

DEPEND="app-arch/unzip"
KEYWORDS="x86"
SLOT="0"
LICENSE="freedist"

src_install () {
	dobin jad
	dodoc Readme.txt
}
