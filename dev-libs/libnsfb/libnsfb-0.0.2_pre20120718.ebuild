# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnsfb/libnsfb-0.0.2_pre20120718.ebuild,v 1.1 2012/07/18 08:25:38 xmw Exp $

EAPI=4

inherit multilib toolchain-funcs

DESCRIPTION="framebuffer abstraction library, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/libnsfb/"
SRC_URI="mirror://gentoo/netsurf-buildsystem-0_p20120717.tar.gz
	mirror://gentoo/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="static-libs"

RDEPEND="media-libs/libsdl
	net-libs/libvncserver
	x11-libs/libxcb
	x11-libs/xcb-util
	x11-libs/xcb-util-image
	x11-libs/xcb-util-keysyms"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

# we don't allow access to /dev/fb0
RESTRICT="test"

src_unpack() {
	default
	mv build "${S}" || die
}

src_prepare() {
	sed -e "/^INSTALL_ITEMS/s: /lib: /$(get_libdir):g" \
		-e "s:-Werror::g" \
		-e "1iNSSHARED=${S}/build" \
		-e "1iNSBUILD=${S}/build/makefiles" \
		-e "s/\$(eval \$(call pkg_config_get_variable,NSFB_XCBPROTO_VERSION,xcb,xcbproto_version))/NSFB_XCBPROTO_VERSION := $(pkg-config --variable=xcbproto_version xcb)/" \
		-i Makefile || die
	sed -e "/^libdir/s:/lib:/$(get_libdir):g" \
		-i ${PN}.pc.in || die
	echo "Q := " >> Makefile.config.override
	echo "CC := $(tc-getCC)" >> Makefile.config.override
	echo "AR := $(tc-getAR)" >> Makefile.config.override
}

src_compile() {
	emake COMPONENT_TYPE=lib-shared
	use static-libs && \
		emake COMPONENT_TYPE=lib-static
}

src_test() {
	emake COMPONENT_TYPE=lib-shared test
	use static-libs && \
		emake COMPONENT_TYPE=lib-static test
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr COMPONENT_TYPE=lib-shared install
	use static-libs && \
		emake DESTDIR="${D}" PREFIX=/usr COMPONENT_TYPE=lib-static install
	dodoc usage
}
