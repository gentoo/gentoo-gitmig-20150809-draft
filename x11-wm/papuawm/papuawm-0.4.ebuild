# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/papuawm/papuawm-0.4.ebuild,v 1.1 2004/04/27 17:38:58 pvdabeel Exp $

DESCRIPTION="PapuaWM, a minimalistic, though useable window manager"
MY_P="${P/papuawm/PapuaWM}"
S=$WORKDIR/$MY_P
SRC_URI="http://www.daimi.au.dk/~pg/papuawm/${MY_P}.tar.gz"

HOMEPAGE="http://papuaos.org/papuawm"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc"

DEPEND="virtual/x11"

src_install () {
	einstall
	dodoc README STATUS TODO papuawm.conf ChangeLog
}
