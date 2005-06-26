# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-emnu/embassy-emnu-1.05-r1.ebuild,v 1.4 2005/06/26 21:02:43 j4rg0n Exp $

inherit embassy-2.10

DESCRIPTION="EMBOSS Menu is Not UNIX - Simple menu of EMBOSS applications"

KEYWORDS="ppc ppc-macos x86"

RDEPEND="sys-libs/ncurses
	${RDEPEND}"

DEPEND="sys-libs/ncurses
	${DEPEND}"
