# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/celestia/celestia-1.4.1-r2.ebuild,v 1.5 2007/03/25 12:29:11 dertobi123 Exp $

WANT_AUTOMAKE="1.9"

inherit eutils flag-o-matic gnome2 kde-functions autotools

DESCRIPTION="OpenGL 3D space simulator"
HOMEPAGE="http://www.shatters.net/celestia/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 sparc ~x86"
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

	# some lua patches to make it work for lua-5.1
	has_version ">=dev-lang/lua-5.1.1" &&  \
		epatch "${FILESDIR}/${P}-lua51.patch"

	# standard set of gcc-4.1 patches
	epatch "${FILESDIR}/${P}-gcc-4.1.patch"

	# fix kde datadir in makefile.am and .desktop location
	epatch "${FILESDIR}/${P}-kde-datadir.patch"

	# add a desktop file that doesn't end up in lost+found
	epatch "${FILESDIR}/${P}-kde-desktop.patch"

	# add a ~/.celestia for extra directories
	epatch "${FILESDIR}/${P}-cfg.patch"

	# strict aliasing from fedora
	epatch "${FILESDIR}/${P}-strictalias.patch"

	# install 3ds models by requests
	epatch "${FILESDIR}/${P}-3dsmodels.patch"

	# fix po/Makefile.in.in to regenerate
	epatch "${FILESDIR}/${P}-locale.patch"

	# fix for as-needed (bug #130091)
	epatch "${FILESDIR}/${P}-as-needed.patch"

	# remove flags to let the user decide
	for cf in -O2 -ffast-math \
		-fexpensive-optimizations \
		-fomit-frame-pointer; do
		sed -i \
			-e "s/${cf}//g" \
			configure.in || die "sed failed"
	done

	# remove an unused gconf macro killing autoconf when no gnome
	if ! use gnome; then
		sed -i \
			-e '/AM_GCONF_SOURCE_2/d' \
			configure.in || die "sed failed"
	fi

	eautoreconf
}

src_compile() {

	if [[ "${mygui}" == "kde" ]]; then
		set-kdedir 3
		set-qtdir 3
		export kde_widgetdir="${KDEDIR}/lib/kde3/plugins/designer"
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
	if [[ "${mygui}" == "gnome" ]]; then
		gnome2_src_install
	else
		emake DESTDIR="${D}" install || die "emake install failed"
		for size in 16 22 32 48 ; do
			insinto /usr/share/icons/hicolor/${size}x${size}/apps
			newins ${S}/src/celestia/kde/data/hi${size}-app-${PN}.png ${PN}.png
		done
	fi
	dodoc AUTHORS README TODO NEWS TRANSLATORS *.txt
	dohtml coding-standards.html
	dosym "${PORTDIR}"/licenses/GPL-2 /usr/share/${PN}/COPYING
}
