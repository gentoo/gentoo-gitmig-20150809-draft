# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-2.0_pre2.ebuild,v 1.2 2004/01/31 14:02:07 tseng Exp $

inherit debug flag-o-matic libtool

MY_PV=${PV/_/}
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="GNU Image Manipulation Program - Development series"
SRC_URI="mirror://gimp/v2.0/testing/${MY_P}.tar.bz2"
HOMEPAGE="http://www.gimp.org/"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~hppa ~sparc"
IUSE="doc python aalib png jpeg tiff wmf gimpprint gtkhtml mmx sse X altivec"

# FIXME : some more things can be (local) USE flagged

RDEPEND=">=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2.2
	>=x11-libs/pango-1.2.2
	>=media-libs/fontconfig-2.2
	>=media-libs/libart_lgpl-2.3.8-r1
	sys-libs/zlib

	gimpprint? ( =media-gfx/gimp-print-4.2* )

	gtkhtml? ( =gnome-extra/libgtkhtml-2* )

	png? ( >=media-libs/libpng-1.2.1 )
	jpeg? ( >=media-libs/jpeg-6b-r2
		media-libs/libexif )
	tiff? ( >=media-libs/tiff-3.5.7 )

	wmf? ( >=media-libs/libwmf-0.2.8 )

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
	# fix gimp-remote behavior
	epatch ${FILESDIR}/${P}-remote_new_behaviour.patch
	epatch ${FILESDIR}/${P}-cpuaccel-pic.patch

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
		`use_enable gimpprint print` \
		`use_with X x` \
		`use_with png libpng` \
		`use_with jpeg libjpeg` \
		`use_with jpeg libexif` \
		`use_with tiff libtiff` \
		`use_with aalib aa` \
		--enable-debug || die

	emake || die

}

src_install() {

	# Workaround portage variable leakage
	local AA=

	make DESTDIR=${D} install || die

	# Install desktop file in the right place
	insinto /usr/share/applications
	newins ${S}/data/misc/gimp.desktop gimp-${PV}.desktop

	dodoc AUTHORS COPYING ChangeL* HACKING INSTALL \
		MAINTAINERS NEWS PLUGIN_MAINTAINERS README* TODO*

}

pkg_postinst() {

	ewarn "The development Gimp series have been reslotted to SLOT 2"
	ewarn "To clean up old 1.3 versions use 'emerge -C =gimp-1.3* -vp'"
	echo ""
	ewarn "If you are upgrading from an earlier 1.3/2.0_pre release, please note that"
	ewarn "the gimprc and sessionrc file formats changed. We suggest you remove"
	ewarn "your personal ~/.gimp-1.3 directory and do a fresh user installation."

}
