# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-emnu/embassy-emnu-1.05-r1.ebuild,v 1.1 2005/03/25 17:44:32 ribosome Exp $

inherit embassy-2.10

DESCRIPTION="EMBOSS Menu is Not UNIX - Simple menu of EMBOSS applications"

KEYWORDS="~x86 ~ppc ~ppc-macos"

RDEPEND="sys-libs/ncurses
	${RDEPEND}"

DEPEND="sys-libs/ncurses
	${DEPEND}"
