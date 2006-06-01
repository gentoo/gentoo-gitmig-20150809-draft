# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/poppler-bindings/poppler-bindings-0.5.1.ebuild,v 1.3 2006/06/01 09:22:13 tcort Exp $

inherit autotools eutils multilib

MY_P=${P/-bindings/}
DESCRIPTION="Poppler bindings are rendering bindings for GUI toolkits for poppler"
HOMEPAGE="http://poppler.freedesktop.org"
SRC_URI="http://poppler.freedesktop.org/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="gtk qt cairo"

RDEPEND="~app-text/poppler-${PV}
	cairo? ( >=x11-libs/cairo-0.5 )
	gtk? (
		>=x11-libs/gtk+-2.6
		>=gnome-base/libglade-2
	)
	qt? ( =x11-libs/qt-3* )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/automake-1.9.6"

S="${WORKDIR}/${MY_P}"

src_unpack(){
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${MY_P}-bindings.patch
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	# Configure needs help finding qt libs on multilib systems
	export QTLIB="${QTDIR}/$(get_libdir)"

	econf --disable-poppler-qt4 --enable-opi \
		$(use_enable cairo cairo-output) \
		$(use_enable gtk poppler-glib) \
		$(use_enable qt poppler-qt) \
		|| die "configuration failed"
	cd poppler
	emake libpoppler-cairo.la || die "cairo failed"
	cd ..
	emake || die "compilation failed"
}

src_install() {
	dolib.a poppler/libpoppler-cairo.la
	make DESTDIR=${D} install || die "make install failed"
	dodoc README AUTHORS ChangeLog NEWS README-XPDF TODO
}

pkg_postinst() {
	ewarn "You need to rebuild everything depending on poppler, use revdep-rebuild"
}
