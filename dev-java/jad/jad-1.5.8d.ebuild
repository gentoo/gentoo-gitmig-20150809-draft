# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: William McArthur <sandymac@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/jad/jad-1.5.8d.ebuild,v 1.2 2002/04/19 05:43:52 sandymac Exp $

S=${WORKDIR}
DESCRIPTION="Jad - the fast JAva Decompiler"
HOMEPAGE="http://kpdus.tripod.com/jad.html"
SRC_URI="http://kpdus.tripod.com/jad/linux/jadls158.zip"

DEPEND="app-arch/unzip"

src_install () {
	dobin jad
	dodoc Readme.txt
}
