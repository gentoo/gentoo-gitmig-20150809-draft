# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/awesome/awesome-3.0_rc2.ebuild,v 1.2 2008/08/14 07:39:45 aballier Exp $

inherit cmake-utils eutils

MY_P="${P/_rc/-rc}"
DESCRIPTION="A dynamic floating and tiling window manager"
HOMEPAGE="http://awesome.naquadah.org/"
SRC_URI="http://awesome.naquadah.org/download/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="dbus doc imlib"

RDEPEND=">=x11-libs/libxcb-1.1
	>=x11-libs/xcb-util-0.2.1
	x11-libs/cairo
	>=dev-libs/glib-2
	dev-libs/libev
	>=dev-lang/lua-5.1
	x11-libs/pango
	>=x11-libs/gtk+-2.2
	dbus? ( >=sys-apps/dbus-1 )
	imlib? ( media-libs/imlib2 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xcb-proto
	>=dev-util/cmake-2.4.7
	app-text/asciidoc
	app-text/xmlto
	doc? (
		app-doc/doxygen
		media-gfx/graphviz
		dev-util/luadoc
	)"

RDEPEND="${RDEPEND}
	app-shells/bash"

S="${WORKDIR}/${MY_P}"

DOCS="AUTHORS BUGS README"

pkg_setup() {
	if ! built_with_use --missing false x11-libs/cairo xcb; then
		eerror "This package you need the useflag xcb enabled on x11-libs/cairo."
		eerror "Please emerge x11-libs/cairo again with the xcb useflag"
		eerror "enabled."
		die "Missing xcb useflag on x11-libs/cairo."
	fi
}

src_compile() {
	local myargs="all"

	mycmakeargs="${mycmakeargs}
		-DSYSCONFDIR=/etc
		$(cmake-utils_use_with imlib IMLIB2)
		$(cmake-utils_use_with dbus DBUS)
	"

	if use doc ; then
		mycmakeargs="${mycmakeargs} -DGENERATE_LUADOC=ON"
		myargs="${myargs} doc"
	else
		mycmakeargs="${mycmakeargs} -DGENERATE_LUADOC=OFF"
	fi
	cmake-utils_src_compile ${myargs}
}

src_install() {
	cmake-utils_src_install

	if use doc ; then
		dohtml -r "${WORKDIR}"/${PN}_build/doc/html/* || die
		mv "${D}"/usr/share/doc/${PN}/luadoc "${D}"/usr/share/doc/${PF}/html/luadoc || die
	fi
	rm -rf "${D}"/usr/share/doc/${PN} || die

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/${PN}-session ${PN} || die

	insinto /usr/share/xsessions
	doins "${FILESDIR}"/${PN}.desktop || die
}
