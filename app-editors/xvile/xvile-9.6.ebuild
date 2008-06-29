# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/xvile/xvile-9.6.ebuild,v 1.1 2008/06/29 19:34:26 hawking Exp $

inherit eutils versionator

MY_PV="$(get_version_component_range 1-2)"
MY_P="${PN/x/}-${MY_PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="VI Like Emacs -- yet another full-featured vi clone"
HOMEPAGE="http://invisible-island.net/vile/"
SRC_URI="ftp://invisible-island.net/vile/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="perl"

RDEPEND="perl? ( dev-lang/perl )
	=app-editors/vile-${MY_PV}$(get_version_component_range 3)
	>=x11-libs/libX11-1.0.0
	>=x11-libs/libXt-1.0.0
	>=x11-libs/libICE-1.0.0
	>=x11-libs/libSM-1.0.0
	>=x11-libs/libXaw-1.0.1
	>=x11-libs/libXpm-3.5.4.2
	>=x11-proto/xproto-7.0.4"
DEPEND="${RDEPEND}
	sys-devel/flex"

src_compile() {
	econf \
		--with-ncurses \
		--with-x \
		$(use_with perl)
	emake || die "emake failed"
}

src_install() {
	dobin xvile || die "dobin failed"
	dodoc CHANGES* README* doc/*
}
