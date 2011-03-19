# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/pango/pango-1.28.3-r1.ebuild,v 1.9 2011/03/19 18:18:09 pacho Exp $

EAPI="3"
GCONF_DEBUG="yes"

inherit autotools eutils gnome2 multilib toolchain-funcs

DESCRIPTION="Internationalized text layout and rendering library"
HOMEPAGE="http://www.pango.org/"

LICENSE="LGPL-2 FTL"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="X doc +introspection test"

RDEPEND=">=dev-libs/glib-2.24:2
	>=media-libs/fontconfig-2.5.0:1.0
	media-libs/freetype:2
	>=x11-libs/cairo-1.7.6[X?]
	X? (
		x11-libs/libXrender
		x11-libs/libX11
		x11-libs/libXft )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/gtk-doc-am-1.13
	doc? (
		>=dev-util/gtk-doc-1.13
		~app-text/docbook-xml-dtd-4.1.2
		x11-libs/libXft )
	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )
	test? (
		>=dev-util/gtk-doc-1.13
		~app-text/docbook-xml-dtd-4.1.2
		x11-libs/libXft )
	X? ( x11-proto/xproto )"

function multilib_enabled() {
	has_multilib_profile || ( use x86 && [ "$(get_libdir)" = "lib32" ] )
}

pkg_setup() {
	tc-export CXX
	G2CONF="${G2CONF}
		$(use_enable introspection)
		$(use_with X x)
		$(use X && echo --x-includes=${EPREFIX}/usr/include)
		$(use X && echo --x-libraries=${EPREFIX}/usr/$(get_libdir))"
	DOCS="AUTHORS ChangeLog* NEWS README THANKS"
}

src_prepare() {
	gnome2_src_prepare

	# make config file location host specific so that a 32bit and 64bit pango
	# wont fight with each other on a multilib system.  Fix building for
	# emul-linux-x86-gtklibs
	if multilib_enabled ; then
		epatch "${FILESDIR}/${PN}-1.26.0-lib64.patch"
	fi

	# Fix heap corruption in font parsing with FreeType2 backend, upstream bug #639882
	epatch "${FILESDIR}/${PN}-1.28.3-heap-corruption.patch"

	# Handle malloc failure in the buffer, upstream #644577
	epatch "${FILESDIR}/${PN}-1.28.3-malloc-failure.patch"

	eautoreconf
	elibtoolize # for Darwin bundles
}

src_install() {
	gnome2_src_install
	find "${ED}/usr/$(get_libdir)/pango/1.6.0/modules" -name "*.la" -delete || die
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ] ; then
		einfo "Generating modules listing..."

		local PANGO_CONFDIR=

		if multilib_enabled ; then
			PANGO_CONFDIR="${EPREFIX}/etc/pango/${CHOST}"
		else
			PANGO_CONFDIR="${EPREFIX}/etc/pango"
		fi

		mkdir -p ${PANGO_CONFDIR}

		pango-querymodules > ${PANGO_CONFDIR}/pango.modules
	fi
}
