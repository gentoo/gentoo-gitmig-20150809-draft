# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-2.0.5.ebuild,v 1.2 2004/11/03 18:41:28 kloeri Exp $

inherit flag-o-matic libtool eutils

DESCRIPTION="GNU Image Manipulation Program"
HOMEPAGE="http://www.gimp.org/"
LICENSE="GPL-2"

P_HELP="gimp-help-2-0.4" #"gimp-help-${PV/\./-}"
S_HELP="$WORKDIR/${P_HELP}"
SRC_URI="mirror://gimp/v2.0/${P}.tar.bz2
	doc? ( mirror://gimp/help/testing/${P_HELP}.tar.gz )"

SLOT="2"
KEYWORDS="~x86 ~ppc ~hppa ~sparc ~amd64 ~mips ~ppc64 ~alpha"
#IUSE="X aalib altivec debug doc gimpprint jpeg mmx mng png python sse svg tiff wmf"
IUSE="aalib altivec debug doc gimpprint jpeg mmx mng png python sse svg tiff wmf"

# FIXME : some more things can be (local) USE flagged
# a few options are detection only, fix them to switch

#	X? ( virtual/x11 )"
RDEPEND="virtual/x11
	>=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2.2
	>=x11-libs/pango-1.2.2
	>=media-libs/fontconfig-2.2
	>=media-libs/libart_lgpl-2.3.8-r1
	sys-libs/zlib

	gimpprint? ( =media-gfx/gimp-print-4.2* )
	doc? ( =gnome-extra/libgtkhtml-2* )

	png? ( >=media-libs/libpng-1.2.1 )
	jpeg? ( >=media-libs/jpeg-6b-r2
		media-libs/libexif )
	tiff? ( >=media-libs/tiff-3.5.7 )
	mng? ( media-libs/libmng )

	wmf? ( >=media-libs/libwmf-0.2.8 )
	svg? ( >=gnome-base/librsvg-2.2 )

	aalib?	( media-libs/aalib )
	python?	( >=dev-lang/python-2.2
		>=dev-python/pygtk-2 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	dev-util/intltool
	doc? ( >=dev-util/gtk-doc-1 )"

src_unpack() {

	unpack ${A}

	cd ${S}
	# Fix linking to older version of gimp if installed - this should
	# void liquidx's hack, so it is removed.
	epatch ${FILESDIR}/ltmain_sh-1.5.0-fix-relink.patch

}

src_compile() {

	# Since 1.3.16, fixes linker problems when upgrading
	elibtoolize

	# Workaround portage variable leakage
	local AA=

	# only use mmx if hardened is not set
	local USE_MMX=

	replace-flags "-march=k6*" "-march=i586"

	# gimp uses inline functions (plug-ins/common/grid.c) (#23078)
	filter-flags "-fno-inline"

	if use hardened; then
		ewarn "hardened use flag suppressing mmx use flag"
		HARDENED_SUPPRESS_MMX="--disable-mmx"
	else
		HARDENED_SUPPRESS_MMX="`use_enable mmx`"
	fi

	econf \
		--disable-default-binary \
		--with-x \
		"${HARDENED_SUPPRESS_MMX}" \
		`use_enable sse` \
		`use_enable altivec` \
		`use_enable doc gtk-doc` \
		`use_enable python` \
		`use_enable gimpprint print` \
		`use_with png libpng` \
		`use_with jpeg libjpeg` \
		`use_with jpeg libexif` \
		`use_with tiff libtiff` \
		`use_with mng libmng` \
		`use_with aalib aa` \
		`use_enable debug` || die

	# X isn't optional (#58003) atm
	#	`use_with X x` \

	emake || die

	if use doc; then
		cd ${S_HELP}
		econf --without-gimp || die
		emake || die
	fi

}

src_install() {

	# Workaround portage variable leakage
	local AA=

	# create these dirs to make the makefile installs these items correctly
	dodir /usr/share/{applications,application-registry,mime-info}

	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeL* HACKING INSTALL \
		MAINTAINERS NEWS PLUGIN_MAINTAINERS README* TODO*

	if use doc; then
		cd ${S_HELP}
		make DESTDIR=${D} install || die
	fi

}
