# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/faad2/faad2-2.6.1-r1.ebuild,v 1.1 2008/05/08 12:08:06 lavajoe Exp $

inherit eutils autotools

DESCRIPTION="AAC audio decoding library"
HOMEPAGE="http://www.audiocoding.com/"
SRC_URI="mirror://sourceforge/faac/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="drm"

RDEPEND=""
DEPEND=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-abi_has_changed.patch"
	epatch "${FILESDIR}/${P}-libtool22.patch"
	epatch "${FILESDIR}/${P}-broken-pipe.patch"
	eautoreconf
}

src_compile() {
	econf \
		$(use_with drm)\
		--without-xmms \
		|| die "econf failed"

	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README README.linux TODO
}

pkg_postinst() {
	elog "Please note that from ${PN}-2.0* to ${P}, ABI has changed"
	elog "So if you are upgrading from those versions, you need to rebuild"
	elog "all the packages linked against ${PN}."
	elog "You can use revdep-rebuild from app-portage/gentoolkit if you are"
	elog "using portage or reconcilio if you are using paludis, or ..."
}
