# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/x11-wm/evilwm/evilwm-0.3.11.ebuild,v 1.4 2002/08/02 17:53:02 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A minimalist, no frills window manager for X."
SRC_URI="http://download.sourceforge.net/evilwm/evilwm_0.3.11-1.tar.gz"
HOMEPAGE="http://evilwm.sourceforge.net"
SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

DEPEND="virtual/x11
	virtual/glibc"

RDEPEND="$DEPEND"

src_compile() {

    emake allinone || die

}

src_install () {

    dodoc ChangeLog README*

    exeinto /usr/bin
    doexe evilwm

    doman evilwm.1

}

