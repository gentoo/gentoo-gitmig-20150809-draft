# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/awesome/awesome-2.3.5.ebuild,v 1.2 2009/02/01 15:16:24 matsuu Exp $

inherit toolchain-funcs eutils

DESCRIPTION="A dynamic floating and tiling window manager"
HOMEPAGE="http://awesome.naquadah.org/"
SRC_URI="http://awesome.naquadah.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="doc gtk"

RDEPEND=">=dev-libs/confuse-2.6
	x11-libs/cairo
	x11-libs/pango
	x11-libs/libX11
	x11-libs/libXrandr
	x11-libs/libXinerama
	gtk? ( x11-libs/gtk+ )
	!gtk? ( media-libs/imlib2 )"

DEPEND="${RDEPEND}
	app-text/asciidoc
	app-text/xmlto
	dev-util/pkgconfig
	x11-proto/xineramaproto
	doc? (
		app-doc/doxygen
		media-gfx/graphviz
	)"

pkg_setup() {
	if ! built_with_use --missing false x11-libs/cairo X ; then
		eerror "Your x11-libs/cairo packagehas been built without X support,"
		eerror "please enable the 'X' USE flag and re-emerge x11-libs/cairo."
		elog "You can enable this USE flag either globally in /etc/make.conf,"
		elog "or just for specific packages in /etc/portage/package.use."
		die "x11-libs/cairo missing X support"
	fi
}

src_compile() {
	econf \
		$(use_with gtk) \
		--docdir="/usr/share/doc/${PF}" || die
	emake || die

	if use doc; then
		emake doc || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/${PN}-session ${PN}

	insinto /usr/share/xsessions
	doins "${FILESDIR}"/${PN}.desktop

	insinto /usr/share/awesome/icons
	doins -r icons/*

	if use doc; then
		dohtml doc/html/*
	fi

	prepalldocs
}
