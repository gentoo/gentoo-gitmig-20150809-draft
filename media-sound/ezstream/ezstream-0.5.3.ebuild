# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ezstream/ezstream-0.5.3.ebuild,v 1.1 2007/12/04 18:04:46 drac Exp $

DESCRIPTION="Enables you to stream mp3 or vorbis files to an icecast server without reencoding"
HOMEPAGE="http://www.icecast.org/ezstream.php"
SRC_URI="http://downloads.xiph.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="taglib"

DEPEND="media-libs/libvorbis
	media-libs/libogg
	>=media-libs/libshout-2.2
	media-libs/libtheora
	dev-libs/libxml2
	taglib? ( media-libs/taglib )"
RDEPEND="${DEPEND}
	net-misc/icecast"

src_compile() {
	econf --enable-examplesdir="/usr/share/doc/${PF}/examples" \
		--docdir="/usr/share/doc/${PF}" $(use_with taglib)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	rm -f "${D}"/usr/share/doc/${PF}/COPYING
	dodoc ChangeLog
	prepalldocs
}
