# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ots/ots-0.2.0.ebuild,v 1.1 2003/07/09 08:16:53 seemant Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Open source Text Summarizer, as used in newer releases of abiword and kword."
HOMEPAGE="http://libots.sourcefourge.net/"
SRC_URI="mirror://sourceforge/libots/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm"


DEPEND="=dev-libs/glib-2*"

src_compile() {
	econf || die
	make || die
}

src_install() {
	einstall || die

	rm -rf ${D}/usr/share/doc/libots

	dohtml -r html

	dodoc AUTHORS BUGS COPYING ChangeLog HACKING INSTALL NEWS README TODO
}
