# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-1.3.23.ebuild,v 1.1 2003/11/26 22:39:10 foser Exp $

inherit debug flag-o-matic libtool

SV="`echo ${PV} | cut -d'.' -f1,2`"

DESCRIPTION="GNU Image Manipulation Program - Development series"
SRC_URI="mirror://gimp/v${SV}/v${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.gimp.org/"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~hppa ~sparc"
IUSE="doc python aalib png jpeg tiff gtkhtml mmx sse X altivec"

# protect against over optimisation (related to #21787)
#replace-flags -Os -O2
#MAKEOPTS="${MAKEOPTS} -j1"

# FIXME : some more things can be (local) USE flagged
RDEPEND=">=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2.2
	>=x11-libs/pango-1.2.2
	>=media-libs/fontconfig-2.2
	>=media-libs/libart_lgpl-2.3.8-r1
	sys-libs/zlib

	gtkhtml? ( =gnome-extra/libgtkhtml-2* )

	png? ( >=media-libs/libpng-1.2.1 )
	jpeg? ( >=media-libs/jpeg-6b-r2
		media-libs/libexif )
	tiff? ( >=media-libs/tiff-3.5.7 )

	aalib?	( media-libs/aalib )
	python?	( >=dev-lang/python-2.2
		>=dev-python/pygtk-1.99.13 )

	X? ( virtual/x11 )"


DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	dev-util/intltool
	doc? ( >=dev-util/gtk-doc-1 )"
#	sys-devel/gettext

src_unpack() {

	unpack ${A}

	cd ${S}
	# Fix linking to older version of gimp if installed - this should
	# void liquidx's hack, so it is removed.
	epatch ${FILESDIR}/ltmain_sh-1.5.0-fix-relink.patch

	# note: this make elibtoolize do some weird things, so disabling - liquidx
	# replace ltmain.sh from libtool 1.5a with libtool 1.4.x
	#cd ${S}; aclocal; automake; libtoolize --force; autoconf

}

src_compile() {

	# Since 1.3.16, fixes linker problems when upgrading
	elibtoolize

	# Workaround portage variable leakage
	local AA=
	local myconf=

	replace-flags "-march=k6*" "-march=i586"
	# gimp uses inline functions (plug-ins/common/grid.c) (#23078)
	filter-flags "-fno-inline"

	econf ${myconf} \
		`use_enable mmx` \
		`use_enable sse` \
		`use_enable altivec` \
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

	# Workaround portage variable leakage
	local AA=

	make DESTDIR=${D} install || die

	# Install desktop file in the right place
	insinto /usr/share/applications
	newins ${S}/data/misc/gimp.desktop gimp-${SV}.desktop

	dodoc AUTHORS COPYING ChangeL* HACKING INSTALL \
		MAINTAINERS NEWS PLUGIN_MAINTAINERS README* TODO*

}

pkg_postinst() {

	ewarn "The ${SV} Gimp series have been reslotted to SLOT 2."
	ewarn "To clean up old ${SV} version remove all ${SV} series and recompile."
	echo ""
	ewarn "If you are upgrading from an earlier 1.3 release, please note that"
	ewarn "the gimprc and sessionrc file formats changed. We suggest you remove"
	ewarn "your personal ~/.gimp-1.3 directory and do a fresh user installation."

}
