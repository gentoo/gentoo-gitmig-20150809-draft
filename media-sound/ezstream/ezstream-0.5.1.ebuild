# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ezstream/ezstream-0.5.1.ebuild,v 1.1 2007/09/20 14:57:49 drac Exp $

DESCRIPTION="Enables you to stream mp3 or vorbis files to an icecast server without reencoding"
HOMEPAGE="http://www.icecast.org/ezstream.php"
SRC_URI="http://downloads.xiph.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples taglib"

DEPEND="media-libs/libvorbis
	media-libs/libogg
	>=media-libs/libshout-2.2
	media-libs/libtheora
	dev-libs/libxml2
	taglib? ( media-libs/taglib )"
RDEPEND="${DEPEND}
	net-misc/icecast"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# handle these in src_install
	sed -e "s:COPYING NEWS README::" -e "s:examples::" -i Makefile.in
}

src_compile() {
	econf $(use_with taglib)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ChangeLog NEWS README

	if use examples; then
		docinto examples
		dodoc examples/{*.xml,*.sh}
	fi
}
