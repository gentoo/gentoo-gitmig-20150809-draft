# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-1.3.20.ebuild,v 1.4 2003/09/20 16:01:21 liquidx Exp $

IUSE="doc python aalib png jpeg tiff gtkhtml mmx sse X"

inherit debug flag-o-matic libtool

DESCRIPTION="Development series of Gimp"
SRC_URI="ftp://ftp.gimp.org/pub/gimp/v1.3/v${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.gimp.org/"
SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~hppa ~sparc"

# protect against over optimisation (related to #21787)
replace-flags -Os -O2
MAKEOPTS="${MAKEOPTS} -j1"

RDEPEND=">=x11-libs/gtk+-2.2
	>=x11-libs/pango-1.2
	>=dev-libs/glib-2.2
	gtkhtml? ( =gnome-extra/libgtkhtml-2* )

	png? ( >=media-libs/libpng-1.2.1 )
	jpeg? ( >=media-libs/jpeg-6b-r2
		media-libs/libexif )
	tiff? ( >=media-libs/tiff-3.5.7 )
		>=media-libs/libart_lgpl-2.3.8-r1

	aalib?	( media-libs/aalib )
	python?	( >=dev-lang/python-2.2
		>=dev-python/pygtk-1.99.13 )

	X? ( virtual/x11 )"


DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	dev-util/intltool
	sys-devel/gettext
	>=sys-devel/libtool-1.4.3-r1
	doc? ( >=dev-util/gtk-doc-1 )"
# be safe and require the latest libtool

src_unpack() {
	unpack ${A}
	# note: this make elibtoolize do some weird things, so disabling - liquidx
	# replace ltmain.sh from libtool 1.5a with libtool 1.4.x
	#cd ${S}; aclocal; automake; libtoolize --force; autoconf
}

src_compile() {
	# since 1.3.16, fixes linker problems when upgrading
	elibtoolize --reverse-deps

	# workaround portage variable leakage
	local AA
	local myconf

	replace-flags "-march=k6*" "-march=i586"
	# gimp uses inline functions (plug-ins/common/grid.c) (#23078)
	filter-flags "-fno-inline"

	econf ${myconf} \
		`use_enable mmx` \
		`use_enable sse` \
		`use_enable doc gtk-doc` \
		`use_enable python` \
		`use_with X x` \
		`use_with png libpng` \
		`use_with jpeg libjpeg` \
		`use_with jpeg libexif` \
		`use_with tiff libtiff` \
		`use_with aalib aa` \
		--enable-debug \
		--disable-print || die

	emake || die
}

src_install() {
	# workaround portage variable leakage
	local AA

	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeL* HACKING INSTALL MAINTAINERS NEWS PLUGIN_MAINTAINERS README* TODO*

	# fix desktop link in the right place
	dodir /usr/share/applications
	rm ${D}/usr/share/gimp/1.3/misc/gimp-1.3.desktop
	mv ${D}/usr/share/gimp/1.3/misc/gimp.desktop ${D}/usr/share/applications/gimp-1.3.desktop

	# HACK! create temporary libtool workaround links - liquidx
	# Finds out if the installed version number and sees if its the same
	# as the one being merged. If not, then we create the symlinks.
	OLD_V=$(find ${ROOT}/usr/lib -maxdepth 1 -name libgimp-1.3.so.*.0.0 | sort | head -n 1 | sed -e 's:.*libgimp-1\.3\.so\.\([0-9]*\)\.0\.0:\1:')
	if [ -n "${OLD_V}" -a ! -f "${D}/usr/lib/libgimp-1.3.so.${OLD_V}.0.0" ]; then
		einfo "Making symlinks from 1.3.${OLD_V} to 1.3.20"
		for x in libgimp libgimpwidgets libgimpbase libgimpcolor; do
			dosym /usr/lib/${x}-1.3.so.20 /usr/lib/${x}-1.3.so.${OLD_V}
		done
	fi		
}

pkg_postinst() {
	ewarn "The 1.3 Gimp series have been reslotted to SLOT 2."
	ewarn "To clean up old 1.3 version remove all 1.3 series and recompile."
}
