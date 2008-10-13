# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/awesome/awesome-3.0-r1.ebuild,v 1.1 2008/10/13 23:39:01 matsuu Exp $

EAPI=1

inherit cmake-utils eutils

DESCRIPTION="A dynamic floating and tiling window manager"
HOMEPAGE="http://awesome.naquadah.org/"
SRC_URI="http://awesome.naquadah.org/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
#IUSE="dbus doc +imlib bash-completion"
IUSE="dbus doc +imlib"

RDEPEND=">=dev-lang/lua-5.1
	>=dev-libs/glib-2
	dev-libs/libev
	dev-util/gperf
	sys-libs/ncurses
	x11-libs/cairo
	x11-libs/libX11
	>=x11-libs/libxcb-1.1
	x11-libs/pango
	>=x11-libs/xcb-util-0.3
	dbus? ( >=sys-apps/dbus-1 )
	imlib? ( media-libs/imlib2 )
	!imlib? ( >=x11-libs/gtk+-2.2 )"

DEPEND="${RDEPEND}
	app-text/asciidoc
	app-text/xmlto
	>=dev-util/cmake-2.6
	dev-util/pkgconfig
	x11-proto/xcb-proto
	doc? (
		app-doc/doxygen
		dev-util/luadoc
		media-gfx/graphviz
	)"

RDEPEND="${RDEPEND}
	app-shells/bash
	|| (
		x11-misc/gxmessage
		x11-apps/xmessage
	)
	|| (
		x11-terms/eterm
		x11-wm/windowmaker
		media-gfx/feh
		x11-misc/hsetroot
		( media-gfx/imagemagick x11-apps/xwininfo )
		media-gfx/xv
		x11-misc/xsri
		media-gfx/xli
		x11-apps/xsetroot
	)"
#		media-gfx/qiv (media-gfx/pqiv doesn't work)
#		x11-misc/chbg #68116
#	bash-completion? ( app-shells/bash-completion )

DOCS="AUTHORS BUGS PATCHES README STYLE"

pkg_setup() {
	if ! built_with_use --missing false x11-libs/cairo xcb ; then
		eerror "Your x11-libs/cairo packagehas been built without xcb support,"
		eerror "please enable the 'xcb' USE flag and re-emerge x11-libs/cairo."
		elog "You can enable this USE flag either globally in /etc/make.conf,"
		elog "or just for specific packages in /etc/portage/package.use."
		die "x11-libs/cairo missing xcb support"
	fi
	if ! built_with_use --missing false x11-libs/libX11 xcb ; then
		eerror "Your x11-libs/libX11 packagehas been built without xcb support,"
		eerror "please enable the 'xcb' USE flag and re-emerge x11-libs/libX11."
		elog "You can enable this USE flag either globally in /etc/make.conf,"
		elog "or just for specific packages in /etc/portage/package.use."
		die "x11-libs/libX11 missing xcb support"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_compile() {
	local myargs="all"

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with imlib IMLIB2)
		$(cmake-utils_use_with dbus DBUS)"

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
}
