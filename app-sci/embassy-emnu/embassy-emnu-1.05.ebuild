# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/embassy-emnu/embassy-emnu-1.05.ebuild,v 1.1 2004/07/20 01:35:10 ribosome Exp $

inherit embassy

DESCRIPTION="EMBOSS Menu is Not UNIX - Simple menu of EMBOSS applications"

KEYWORDS="~x86"

RDEPEND="sys-libs/ncurses
	${RDEPEND}"

DEPEND="sys-libs/ncurses
	${DEPEND}"
