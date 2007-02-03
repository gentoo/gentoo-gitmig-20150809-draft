# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/celestia/celestia-1.4.1-r1.ebuild,v 1.2 2007/02/03 17:20:36 flameeyes Exp $

#WANT_AUTOCONF="2.5"
WANT_AUTOMAKE="1.9"

inherit eutils flag-o-matic gnome2 kde-functions autotools

DESCRIPTION="Space 3D simulator"
HOMEPAGE="http://www.shatters.net/celestia/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="cairo gnome gtk kde arts threads nls lua"

DEPEND="virtual/glu
	media-libs/jpeg
	media-libs/libpng
	gtk? ( !gnome? ( !kde? (
		>=x11-libs/gtk+-2.6
		>=x11-libs/gtkglext-1.0
	) ) )
	gnome? ( !kde? (
		>=x11-libs/gtk+-2.6
		>=x11-libs/gtkglext-1.0
		>=gnome-base/libgnomeui-2.0
	) )
	kde?  ( !gnome? ( >=kde-base/kdelibs-3.0.5 ) )
	!gtk? ( !gnome? ( !kde? ( virtual/glut ) ) )
	arts? ( kde-base/arts )
	lua? ( >=dev-lang/lua-5.0 )
	cairo? ( x11-libs/cairo )"

pkg_setup() {
	# Check for one for the following use flags to be set.
	if ! use gnome && use kde; then
		einfo "USE=\"kde\" detected."
		mygui="kde"
	elif ! use kde && use gnome; then
		einfo "USE=\"gnome\" detected."
		USE_DESTDIR="1"
		mygui="gnome"
	elif ! use kde && ! use gnome && use gtk; then
		einfo "USE=\"gtk\" detected."
		mygui="gtk"
	elif use kde && use gnome; then
		einfo "Both gnome and kde support requested. Defaulting to kde"
		mygui="kde"
	else
		ewarn "If you want to use the full gui, set USE=\"{kde/gnome/gtk}\""
		ewarn "Defaulting to glut support (no GUI)."
		mygui="glut"
	fi

	einfo "If you experience problems building celestia with nvidia drivers,"
	einfo "you can try:"
	einfo "eselect opengl set xorg-x11"
	einfo "emerge celestia"
	einfo "eselect opengl set nvidia"
}

src_unpack() {

	unpack ${A}
	cd "${S}"

	# standard set of gcc-4.1 patches
	epatch "${FILESDIR}/${P}-gcc-4.1.patch"
	# fix kde datadir in makefile.am and .desktop location
	epatch "${FILESDIR}/${P}-kde-datadir.patch"
	#epatch "${FILESDIR}/${P}-makefile.am.patch"
	# add a ~/.celestia for extra directories
	epatch "${FILESDIR}/${P}-cfg.patch"
	# some lua patches on celx.cpp
	epatch "${FILESDIR}/${P}-lua.patch"
	# strict aliasing from mandriva
	epatch "${FILESDIR}/${P}-strictalias.patch"

	# remove agressive flags to let the user decide
	sed -i \
		-e 's/-ffast-math -fexpensive-optimizations//g' \
		configure.in || die "sed failed"

	# remove an unused gconf macro killing autoconf
	if ! use gnome; then
		sed -i \
			-e '/AM_GCONF_SOURCE_2/d' \
			configure.in || die "sed failed"
	fi

	# nasty hack for gettext generated file
	sed -i \
		-e 's:@MKINSTALLDIRS@:$(top_builddir)/admin/mkinstalldirs:' \
		po/Makefile.in.in || die "sed failed"

	eautoreconf
}

src_compile() {

	if [[ "${mygui}" == "kde" ]]; then
		set-kdedir 3
		set-qtdir 3
		export kde_widgetdir="$KDEDIR/lib/kde3/plugins/designer"
	fi
	addwrite ${QTDIR}/etc/settings

	filter-flags "-funroll-loops -frerun-loop-opt"

	econf \
		--with-${mygui} \
		--enable-pch \
		$(use_with arts) \
		$(use_with lua) \
		$(use_enable cairo) \
		$(use_enable threads threading) \
		$(use_enable nls) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	#dodir /usr/share/celestia
	if [[ "${mygui}" == "gnome" ]]; then
		gnome2_src_install
	else
		#einstall || die "einstall failed"
		emake DESTDIR="${D}" install || die "emake install failed"
		for size in 16 22 32 48 ; do
			insinto /usr/share/icons/hicolor/${size}x${size}/apps/
			newins ${S}/src/celestia/kde/data/hi${size}-app-${PN}.png ${PN}.png
		done
	fi
	dodoc AUTHORS README TODO NEWS TRANSLATORS ChangeLog \
		CelestiaKeyAssignments.txt KbdMouseJoyControls.txt devguide.txt
	dohtml coding-standards.html manual/*.html manual/*.css
	insinto /usr/share/celestia/models/
	for m in models/*.3ds; do
		doins ${m}
	done
}
