# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: William McArthur <Leknor@Leknor.com>
# $Header: /var/cvsroot/gentoo-x86/dev-java/jad/jad-1.5.8d.ebuild,v 1.1 2002/04/13 13:59:36 karltk Exp $

S=${WORKDIR}
DESCRIPTION="Jad - the fast JAva Decompiler"
HOMEPAGE="http://kpdus.tripod.com/jad.html"
SRC_URI="http://kpdus.tripod.com/jad/linux/jadls158.zip"

DEPEND="app-arch/unzip"

src_install () {
	dobin jad
	dodoc Readme.txt
}
