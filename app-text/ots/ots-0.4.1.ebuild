# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ots/ots-0.4.1.ebuild,v 1.1 2003/08/18 23:07:58 foser Exp $

IUSE="doc"

DESCRIPTION="Open source Text Summarizer, as used in newer releases of abiword and kword."
HOMEPAGE="http://libots.sourcefourge.net/"
SRC_URI="mirror://sourceforge/libots/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm"


RDEPEND="=dev-libs/glib-2*
	>=dev-libs/libxml2-2.4.23
	>=dev-libs/popt-1.5"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-0.9 )"

src_compile() {

	econf `use_enable doc gtk-doc` || die

	make || die

}

src_install() {

	einstall || die

	rm -rf ${D}/usr/share/doc/libots

	dodoc AUTHORS BUGS COPYING ChangeLog HACKING INSTALL NEWS README TODO

	cd ${S}/doc/html
	dohtml -r ./
}
