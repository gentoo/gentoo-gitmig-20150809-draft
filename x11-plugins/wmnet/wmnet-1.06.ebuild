# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnet/wmnet-1.06.ebuild,v 1.2 2002/10/03 15:03:16 raker Exp $

S=${WORKDIR}/${P}

DESCRIPTION="WMnet is a dock.app network monitor"
SRC_URI="http://www.digitalkaos.net/linux/${PN}/download/${P}.tar.gz"
HOMEPAGE="http://http://www.digitalkaos.net/linux/wmnet/"

DEPEND="virtual/x11"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_compile() {

	xmkmf || die "xmkmf failed"

	emake || die "parallel make failed"

}

src_install() {

	dobin wmnet

	dohtml wmnet.1x.html

	newman wmnet.man wmnet.1

	dodoc README Changelog

}
