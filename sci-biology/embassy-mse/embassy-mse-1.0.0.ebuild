# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-mse/embassy-mse-1.0.0.ebuild,v 1.3 2005/03/02 23:47:42 j4rg0n Exp $

inherit embassy

DESCRIPTION="EMBOSS integrated version of MSE - Multiple Sequence Editor"

KEYWORDS="x86 ~ppc ppc-macos"

src_install() {
	embassy_src_install
	insinto /usr/include/emboss/mse
	doins h/*.h
}
