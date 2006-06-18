# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-9999.ebuild,v 1.3 2006/06/18 17:53:51 brix Exp $

inherit alternatives cvs eutils fdo-mime flag-o-matic

ECVS_SERVER="anoncvs.gimp.org:/cvs/gnome"
ECVS_MODULE="gimp"
ECVS_AUTH="pserver"
ECVS_USER="anonymous"

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="GNU Image Manipulation Program from CVS HEAD"
HOMEPAGE="http://www.gimp.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="-*"

IUSE="alsa aalib altivec debug doc gtkhtml gimpprint gnome jpeg lcms mmx mng pdf png python smp sse svg tiff wmf"

RDEPEND=">=dev-libs/glib-2.8.2
		>=x11-libs/gtk+-2.8.8
		>=x11-libs/pango-1.4
		>=media-libs/freetype-2.1.7
		>=media-libs/fontconfig-2.2
		>=media-libs/libart_lgpl-2.3.8-r1
		sys-libs/zlib
		dev-libs/libxml2
		dev-libs/libxslt
		x11-themes/hicolor-icon-theme
		aalib? ( media-libs/aalib )
		alsa? ( >=media-libs/alsa-lib-1.0.0 )
		doc? ( app-doc/gimp-help )
		gimpprint? ( =media-gfx/gimp-print-4.2* )
		gnome? ( >=gnome-base/gnome-vfs-2.10.0
				>=gnome-base/libgnomeui-2.10.0
				>=gnome-base/gnome-keyring-0.4.5
				>=gnome-base/libgnomeprint-2.10.0 )
		gtkhtml? ( =gnome-extra/gtkhtml-2* )
		jpeg? ( >=media-libs/jpeg-6b-r2
				media-libs/libexif )
		lcms? ( media-libs/lcms )
		mng? ( media-libs/libmng )
		pdf? ( >=app-text/poppler-bindings-0.3.1 )
		png? ( >=media-libs/libpng-1.2.2 )
		python?	( >=dev-lang/python-2.2.1
				>=dev-python/pygtk-2 )
		tiff? ( >=media-libs/tiff-3.5.7 )
		svg? ( >=gnome-base/librsvg-2.2 )
		wmf? ( >=media-libs/libwmf-0.2.8.2 )"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.12.0
		>=dev-util/intltool-0.31
		doc? ( >=dev-util/gtk-doc-1 )"

pkg_setup() {
	if use pdf && ! built_with_use app-text/poppler-bindings gtk; then
		eerror
		eerror "This package requires app-text/poppler compiled with GTK+ support."
		eerror "Please reemerge app-text/poppler with USE=\"gtk\"."
		eerror
		die "Please reemerge app-text/poppler with USE=\"gtk\"."
	fi
}

src_unpack() {
	cvs_src_unpack

	cd "${S}"
	epatch ${FILESDIR}/${P}-autogen-gentoo.patch
}

src_compile() {
	# gimp uses inline functions (plug-ins/common/grid.c) (#23078)
	# gimp uses floating point math, needs accuracy (#98685)
	filter-flags "-fno-inline" "-ffast-math"

	"${S}"/autogen.sh $(use_enable doc gtk-doc) || die "autogen.sh failed"

	econf \
		--disable-default-binary \
		--with-x \
		$(use_with aalib aa) \
		$(use_with alsa) \
		$(use_enable altivec) \
		$(use_enable debug) \
		$(use_enable doc gtk-doc) \
		$(use_enable gimpprint print) \
		$(use_with gnome gnome-print) \
		$(use_with gtkhtml gtkhtml2) \
		$(use_with jpeg libjpeg) \
		$(use_with jpeg libexif) \
		$(use_with lcms) \
		$(use_enable mmx) \
		$(use_with mng libmng) \
		$(use_with png libpng) \
		$(use_with pdf poppler) \
		$(use_enable python) \
		$(use_enable smp mp) \
		$(use_enable sse) \
		$(use_with svg librsvg) \
		$(use_with tiff libtiff) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog* HACKING NEWS README*
}

pkg_postinst() {
	local binary

	for binary in gimp gimp-console gimp-remote gimptool; do
		alternatives_auto_makesym "/usr/bin/${binary}" "/usr/bin/${binary}-[0-9].[0-9]"
	done

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	einfo
	einfo "If you want Postscript file support, emerge ghostscript."
	einfo
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
