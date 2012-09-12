# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pdv/pdv-1.5.1-r2.ebuild,v 1.11 2012/09/12 03:48:58 ottxor Exp $

EAPI=4

inherit eutils autotools

DESCRIPTION="build a self-extracting and self-installing binary package"
HOMEPAGE="http://sourceforge.net/projects/pdv"
SRC_URI="mirror://sourceforge/pdv/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~hppa ppc x86 ~x86-linux ~ppc-macos"
IUSE="X"

DEPEND="X? ( >=x11-libs/openmotif-2.3:0
	>=x11-libs/libX11-1.0.0
	>=x11-libs/libXt-1.0.0
	>=x11-libs/libXext-1.0.0
	>=x11-libs/libXp-1.0.0 )"
RDEPEND="${DEPEND}"

src_prepare() {
	# fix a size-of-variable bug
	epatch "${FILESDIR}"/${P}-opt.patch
	# fix a free-before-use bug
	epatch "${FILESDIR}"/${P}-early-free.patch
	# fix a configure script bug
	epatch "${FILESDIR}"/${P}-x-config.patch
	# fix default args bug from assuming 'char' is signed
	epatch "${FILESDIR}"/${P}-default-args.patch
	# prevent pre-stripped binaries
	epatch "${FILESDIR}"/${P}-no-strip.patch

	# re-build configure script since patch was applied to configure.in
	cd "${S}"/X11
	eautoreconf
}

src_configure() {
	local myconf=""
	use X || myconf="--without-x" # configure script is broken, cant use use_with
	econf ${myconf}
}

src_install() {
	dobin pdv pdvmkpkg
	doman pdv.1 pdvmkpkg.1
	if use X ; then
		dobin X11/xmpdvmkpkg
		doman xmpdvmkpkg.1
	fi
	dodoc AUTHORS ChangeLog NEWS README pdv.lsm
}
