# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmnet/wmnet-1.06.ebuild,v 1.2 2002/07/08 21:31:07 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="WMnet is a dock.app network monitor"
SRC_URI="http://www.digitalkaos.net/linux/${PN}/download/${P}.tar.gz"
HOMEPAGE="http://http://www.digitalkaos.net/linux/wmnet/"
DEPEND="virtual/glibc x11-base/xfree"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

src_compile() {
	xmkmf
	emake || die
}

src_install() {
	dobin wmnet
	dohtml wmnet.1x.html
	newman wmnet.man wmnet.1
	dodoc README Changelog
}
