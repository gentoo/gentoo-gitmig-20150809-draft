# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qjackctl/qjackctl-0.2.1.ebuild,v 1.1 2004/01/15 01:29:25 wmertens Exp $ 

IUSE=""

DESCRIPTION="A Qt application to control the JACK Audio Connection Kit"
HOMEPAGE="http://qjackctl.sf.net/"
SRC_URI="mirror://sourceforge/qjackctl/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	>=x11-libs/qt-3.1.1
	virtual/jack"

src_install () {
	einstall || die "make install failed"
}
