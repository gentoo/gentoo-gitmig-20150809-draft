# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/xvile/xvile-9.4d-r1.ebuild,v 1.4 2007/07/22 09:10:28 omp Exp $

inherit eutils versionator

MY_PV="$(get_version_component_range 1-2)"
MY_P="${PN/x/}-${MY_PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="VI Like Emacs -- yet another full-featured vi clone"
HOMEPAGE="http://www.clark.net/pub/dickey/vile/vile.html"
SRC_URI="ftp://ftp.phred.org/pub/vile/${MY_P}.tgz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.4a.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.4b.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.4c.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.4d.patch.gz"

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

src_unpack() {
	unpack ${MY_P}.tgz
	cd "${S}" || die "cd failed"

	local p
	for p in "${DISTDIR}"/vile-${PV%[a-z]}[a-${P##*[0-9]}].patch.gz; do
		epatch ${p} || die "epatch failed"
	done
}

src_compile() {
	econf \
		--with-ncurses \
		--with-x \
		`use_with perl` \
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	dobin xvile || die
	dodoc CHANGES* README* doc/*
}
