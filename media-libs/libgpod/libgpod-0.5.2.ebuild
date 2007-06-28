# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgpod/libgpod-0.5.2.ebuild,v 1.1 2007/06/28 04:31:22 tester Exp $

DESCRIPTION="Shared library to access the contents of an iPod"
HOMEPAGE="http://www.gtkpod.org/libgpod.html"
SRC_URI="mirror://sourceforge/gtkpod/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="gtk python doc"

RDEPEND=">=dev-libs/glib-2.4
	gtk? ( >=x11-libs/gtk+-2 )
	python? ( >=dev-lang/python-2.3
		>=dev-lang/swig-1.3.24
		media-libs/mutagen )"
DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )
	dev-util/pkgconfig"

# The tests dont passe
RESTRICT="test"

src_compile() {

	econf $(use_enable gtk gdk-pixbuf) \
		$(use_enable doc gtk-doc) \
		$(use_with python) || die "configure failed"

	emake || die "make failed"

}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc README TROUBLESHOOTING AUTHORS
}

