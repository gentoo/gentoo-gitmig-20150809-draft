# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ots/ots-0.4.1.ebuild,v 1.11 2005/11/20 22:57:48 vanquirius Exp $

DESCRIPTION="Open source Text Summarizer, as used in newer releases of abiword and kword."
HOMEPAGE="http://libots.sourceforge.net/"
SRC_URI="mirror://sourceforge/libots/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~alpha ~hppa ~mips amd64"
IUSE=""

RDEPEND="=dev-libs/glib-2*
	>=dev-libs/libxml2-2.4.23
	>=dev-libs/popt-1.5"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	# bug 97448
	econf --disable-gtk-doc || die
	# parallel make fails, bug 112932
	emake -j1 || die
}

src_install() {
	einstall || die
	rm -rf "${D}"/usr/share/doc/libots
	dodoc AUTHORS BUGS ChangeLog HACKING NEWS README TODO
	cd "${S}"/doc/html
	dohtml -r ./
}
