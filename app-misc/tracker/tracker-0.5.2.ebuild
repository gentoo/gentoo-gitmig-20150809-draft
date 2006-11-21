# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tracker/tracker-0.5.2.ebuild,v 1.1 2006/11/21 17:48:20 compnerd Exp $

inherit eutils autotools flag-o-matic

DESCRIPTION="A tagging metadata database, search tool and indexer"
HOMEPAGE="http://www.gnome.org/~jamiemcc/tracker/"
SRC_URI="http://www.gnome.org/~jamiemcc/tracker/${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="fam gnome gsf gstreamer jpeg pdf png xine"

RDEPEND=">=dev-libs/glib-2.12.0
		 >=dev-libs/gmime-2.1.0
		 >=x11-libs/pango-1.0.0
		 >=sys-apps/dbus-0.60
		 >=dev-db/sqlite-3.2
		 fam? ( >=app-admin/gamin-0.1.7 )
		 gnome? (
					>=x11-libs/gtk+-2.8
					>=gnome-base/libgnome-2.14
					>=gnome-base/gnome-vfs-2.10
					>=gnome-base/libgnomeui-2.14
					>=gnome-base/gnome-desktop-2.14
				)
		 gsf? ( >=gnome-extra/libgsf-1.13 )
		 gstreamer? ( >=media-libs/gstreamer-0.10 )
		 jpeg? ( >=media-gfx/exif-0.6 )
		 pdf?	(
		 			>=x11-libs/cairo-1.0
					>=app-text/poppler-bindings-0.5.0
				)
		 png? ( >=media-libs/libpng-1.2 )
		 xine? ( >=media-libs/xine-lib-1.0 )"

DEPEND="${RDEPEND}
		>=dev-util/intltool-0.22
		>=sys-devel/gettext-0.14
		>=dev-util/pkgconfig-0.20"

pkg_setup() {
	if built_with_use 'dev-db/sqlite' 'nothreadsafe' ; then
		eerror "You must build sqlite with threading support"
		die "dev-db/sqlite built with nothreadsafe"
	fi

	if ! built_with_use 'app-text/poppler-bindings' 'gtk' ; then
		ewarn "You must build poppler-bindings with gtk to get support for PDFs."
		die "poppler-bindings needs gtk support"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-0.5.2-configure.in.patch
	eautoreconf
}

src_compile() {
	filter-ldflags -Wl,--as-needed

	econf --enable-external-sqlite \
		  $(use_enable fam) \
		  $(use_enable gnome gui) \
		  $(use_enable gstreamer) \
		  $(use_enable jpeg exif) \
		  $(use_enable pdf) \
		  $(use_enable png) \
		  $(use_enable xine libxine) \
		|| die "configure failed"

	emake || die "build failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
