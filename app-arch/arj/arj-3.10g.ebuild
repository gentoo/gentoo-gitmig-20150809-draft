# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/arj/arj-3.10g.ebuild,v 1.1 2003/07/21 08:21:19 raker Exp $

IUSE=""

S=${WORKDIR}/${PN}

DESCRIPTION="Utility for opening arj archives."
HOMEPAGE="http://arj.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86 ~ppc ~sparc"

DEPEND=""

RESTRICT=nostrip

src_compile() 
{
    cd ${S}
    cd gnu
    autoconf
    econf || die
    cd ../
    make prepare || die
    make package || die
}

src_install() 
{
    cd ${S}/linux-gnu/en/rs/u
    dobin bin/*
    dodoc doc/arj/*
    
    cd ${S}
    dodoc ChangeLog
}
