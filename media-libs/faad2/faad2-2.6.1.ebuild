# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/faad2/faad2-2.6.1.ebuild,v 1.2 2007/11/25 13:06:46 aballier Exp $

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
