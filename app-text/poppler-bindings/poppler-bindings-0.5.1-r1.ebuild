# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/poppler-bindings/poppler-bindings-0.5.1-r1.ebuild,v 1.2 2006/04/08 11:15:57 flameeyes Exp $

inherit autotools eutils multilib

MY_P=${P/-bindings/}
DESCRIPTION="Poppler bindings are rendering bindings for GUI toolkits for poppler"
HOMEPAGE="http://poppler.freedesktop.org"
SRC_URI="http://poppler.freedesktop.org/${MY_P}.tar.gz
	http://dev.gentoo.org/~genstef/files/dist/${MY_P}-cvs20060401.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="gtk qt cairo qt4"

RDEPEND="~app-text/poppler-${PV}
	cairo? ( >=x11-libs/cairo-0.5 )
	gtk? (
		>=x11-libs/gtk+-2.6
		>=gnome-base/libglade-2
	)
	qt? ( =x11-libs/qt-3* )
	qt4? ( =x11-libs/qt-4* )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/automake-1.9.6"

S="${WORKDIR}/${MY_P}"

src_unpack(){
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${MY_P}-cvs20060401.patch
	epatch ${FILESDIR}/${MY_P}-r1-bindings.patch
	epatch ${FILESDIR}/${MY_P}-arthur.patch

	epatch "${FILESDIR}/${MY_P}-qt-pthread.patch"

	AT_M4DIR="m4" eautoreconf
	sed -i s:/usr/lib/qt:/usr/lib/qt4: configure
}

src_compile() {
	# Configure needs help finding qt libs on multilib systems
	export QTLIB="${QTDIR}/$(get_libdir)"

	econf --enable-opi \
		$(use_enable cairo cairo-output) \
		$(use_enable gtk poppler-glib) \
		$(use_enable qt poppler-qt) \
		$(use_enable qt4 poppler-qt4) \
		|| die "configuration failed"
	cd poppler
	if use cairo; then
		emake libpoppler-cairo.la || die "cairo failed"
	fi
	if use qt4; then
		emake libpoppler-arthur.la || die "arthur failed"
	fi
	cd ..
	emake || die "compilation failed"
}

src_install() {
	dolib.a poppler/libpoppler-cairo.la
	make DESTDIR=${D} install || die "make install failed"
}

pkg_postinst() {
	ewarn "You need to rebuild everything depending on poppler, use revdep-rebuild"
}
