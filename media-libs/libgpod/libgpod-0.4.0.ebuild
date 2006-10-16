# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgpod/libgpod-0.4.0.ebuild,v 1.4 2006/10/16 20:10:37 tester Exp $

inherit eutils autotools

DESCRIPTION="Shared library to access the contents of an iPod"
HOMEPAGE="http://www.gtkpod.org/libgpod.html"
SRC_URI="mirror://sourceforge/gtkpod/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="gtk python"

RDEPEND=">=dev-libs/glib-2.4
		gtk? ( >=x11-libs/gtk+-2 )
		python? ( >=dev-lang/python-2.3
			>=dev-lang/swig-1.3.24
			>=dev-python/eyeD3-0.6.6 )"
DEPEND="${RDEPEND}
		sys-devel/autoconf
		sys-devel/libtool
		>=dev-util/intltool-0.2.9"

src_unpack() {
	unpack ${A}

	cd  ${S}
	epatch ${FILESDIR}/libgpod-0.4.0-test-nogdk.patch

	# Dont run aclocal, it breaks
	eautomake
	eautoconf
	eautoheader
	elibtoolize
}

src_compile() {

	econf $(use_enable gtk gdk-pixbuf) \
		$(use_with python) || die "configure failed"

	emake || die "make failed"

}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc README
}

