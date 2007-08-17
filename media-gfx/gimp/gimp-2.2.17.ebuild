# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-2.2.17.ebuild,v 1.9 2007/08/17 16:29:53 hanno Exp $

inherit flag-o-matic libtool eutils fdo-mime alternatives multilib python

DESCRIPTION="GNU Image Manipulation Program"
HOMEPAGE="http://www.gimp.org/"

SRC_URI="mirror://gimp/v2.2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="aalib altivec debug doc gtkhtml gimpprint hardened jpeg lcms mmx mng png
python smp sse svg tiff wmf"

RDEPEND=">=dev-libs/glib-2.4.5
	>=x11-libs/gtk+-2.4.4
	>=x11-libs/pango-1.4
	>=media-libs/freetype-2.1.7
	>=media-libs/fontconfig-2.2
	>=media-libs/libart_lgpl-2.3.8-r1
	sys-libs/zlib
	dev-libs/libxml2
	dev-libs/libxslt

	gimpprint? ( =media-gfx/gimp-print-4.2* )
	gtkhtml? ( =gnome-extra/gtkhtml-2* )

	png? ( >=media-libs/libpng-1.2.10 )
	jpeg? ( >=media-libs/jpeg-6b-r2
		media-libs/libexif )
	tiff? ( >=media-libs/tiff-3.5.7 )
	mng? ( media-libs/libmng )

	wmf? ( >=media-libs/libwmf-0.2.8.2 )
	svg? ( >=gnome-base/librsvg-2.2 )

	aalib?	( media-libs/aalib )
	python?	( >=dev-lang/python-2.2
		>=dev-python/pygtk-2 )
	lcms? ( media-libs/lcms )
	doc? ( app-doc/gimp-help )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	dev-util/intltool
	sys-devel/gettext
	doc? ( >=dev-util/gtk-doc-1 )"

src_unpack() {

	unpack "${A}"
	cd "${S}"

	# fixes bug #76050, allows for themable icons
	sed -i -e s,@gimpdatadir@/images/@GIMP_DESKTOP_ICON@,@GIMP_DESKTOP_ICON@, ${S}/data/misc/gimp.desktop.in.in

	# Fix linking to older version of gimp if installed - this should
	# void liquidx's hack, so it is removed.
	epatch "${FILESDIR}/ltmain_sh-1.5.0-fix-relink.patch"
}

src_compile() {

	# Since 1.3.16, fixes linker problems when upgrading
	elibtoolize

	# Workaround portage variable leakage
	local AA=

	# only use mmx if hardened is not set
	local USE_MMX=

	# remove this for now, since I have 3 reports that this is
	# not necessary
	# replace-flags "-march=k6*" "-march=i586"

	# gimp uses inline functions (plug-ins/common/grid.c) (#23078)
	# gimp uses floating point math, needs accuracy (#98685)
	filter-flags "-fno-inline" "-ffast-math"

	# this is fixed in HEAD, but apply when using mmx
	if use mmx; then
		append-flags "-fomit-frame-pointer"
	fi

	if use hardened; then
		ewarn "hardened use flag suppressing mmx use flag"
		HARDENED_SUPPRESS_MMX="--disable-mmx"
	elif use x86; then
		HARDENED_SUPPRESS_MMX="`use_enable mmx`"
	elif use amd64; then
		HARDENED_SUPPRESS_MMX="--enable-mmx"
	fi

	local myconf

	# Hard enable SIMD assembler code for AMD64.
	if use x86; then
		myconf="${myconf} `use_enable sse`"
	elif use amd64; then
		myconf="${myconf} --enable-sse"
	fi

	econf \
		--disable-default-binary \
		--with-x \
		"${HARDENED_SUPPRESS_MMX}" \
		${myconf} \
		`use_enable altivec` \
		`use_enable doc gtk-doc` \
		`use_enable python` \
		`use_enable gimpprint print` \
		`use_with png libpng` \
		`use_with jpeg libjpeg` \
		`use_with jpeg libexif` \
		`use_enable smp mp` \
		`use_with tiff libtiff` \
		`use_with mng libmng` \
		`use_with aalib aa` \
		`use_with lcms` \
		`use_with gtkhtml gtkhtml2` \
		`use_with svg librsvg` \
		`use_enable debug` || die

	# X isn't optional (#58003) atm
	#	`use_with X x` \

	emake || die
}

src_install() {
	# Workaround portage variable leakage
	local AA=

	# create these dirs to make the makefile installs these items correctly
	dodir /usr/share/{applications,application-registry,mime-info}

	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog* HACKING NEWS README*

	# Create the gimp-remote link, see bug #36648
	dosym gimp-remote-2.2 /usr/bin/gimp-remote
}

pkg_postinst() {
	alternatives_auto_makesym "/usr/bin/gimp" "/usr/bin/gimp-[0-9].[0-9]"

	# fix for bug #76050
	ln -s $(gimptool-2.0 --gimpdatadir)/images/wilber-icon.png \
		${ROOT}/usr/share/pixmaps/

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	elog ""
	elog "If you want Postscript file support, emerge ghostscript."
	elog ""

	python_mod_optimize /usr/$(get_libdir)/gimp/2.0/python \
		/usr/$(get_libdir)/gimp/2.0/plug-ins
}

pkg_postrm() {
	[[ ! -f ${ROOT}/usr/bin/gimp-2.2 ]] && \
		rm -f ${ROOT}/usr/share/pixmaps/wilber-icon.png

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	python_mod_cleanup /usr/$(get_libdir)/gimp/2.0/python \
		/usr/$(get_libdir)/gimp/2.0/plug-ins
}
