# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/latex-texpower/latex-texpower-0.0.8h.ebuild,v 1.3 2003/04/02 00:13:40 pylon Exp $

inherit latex-package

TP=texpower-${PV}

S=${WORKDIR}/${TP}
DESCRIPTION="TeXPower is a bundle of style and class files for creating dynamic online presentations."
SRC_URI="mirror://sourceforge/texpower/${TP}.tar.gz"
HOMEPAGE="http://texpower.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc"
