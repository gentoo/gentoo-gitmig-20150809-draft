# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmhdplop/wmhdplop-0.9.9-r1.ebuild,v 1.1 2010/06/29 09:53:56 voyageur Exp $

EAPI="2"

inherit eutils multilib

DESCRIPTION="a dockapp for monitoring disk activities with fancy visuals."
HOMEPAGE="http://hules.free.fr/wmhdplop"
SRC_URI="http://hules.free.fr/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gkrellm"

RDEPEND="media-libs/imlib2[X]
	x11-libs/libX11
	x11-libs/libXext
	media-fonts/corefonts
	>=media-libs/freetype-2"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	gkrellm? ( dev-util/pkgconfig
		>=app-admin/gkrellm-2 )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-64bit.patch
	sed -i -e "s:-O3 -fomit-frame-pointer -ffast-math:${CFLAGS}:" "${S}"/configure
}

src_configure() {
	econf $(use_enable gkrellm)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README || die

	insinto /usr/$(get_libdir)/gkrellm2/plugins
	use gkrellm && doins gkhdplop.so
}
