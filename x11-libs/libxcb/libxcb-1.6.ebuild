# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxcb/libxcb-1.6.ebuild,v 1.9 2010/09/28 13:49:39 ssuominen Exp $

EAPI=3

inherit python xorg-2

DESCRIPTION="X C-language Bindings library"
HOMEPAGE="http://xcb.freedesktop.org/"
EGIT_REPO_URI="git://anongit.freedesktop.org/git/xcb/libxcb"
[[ ${PV} != 9999* ]] && \
	SRC_URI="http://xcb.freedesktop.org/dist/${P}.tar.bz2"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ~ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="doc selinux"

RDEPEND="x11-libs/libXau
	x11-libs/libXdmcp
	dev-libs/libpthread-stubs"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	dev-libs/libxslt
	>=x11-proto/xcb-proto-1.6
	=dev-lang/python-2*[xml]"

pkg_setup() {
	python_set_active_version 2
	xorg-2_pkg_setup
	CONFIGURE_OPTIONS="$(use_enable doc build-docs)
		$(use_enable selinux)
		--enable-xinput"
}
