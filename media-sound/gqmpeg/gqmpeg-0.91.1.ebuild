# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gqmpeg/gqmpeg-0.91.1.ebuild,v 1.10 2011/03/12 09:42:12 radhermit Exp $

EAPI=2

DESCRIPTION="front end to various audio players, including mpg123"
HOMEPAGE="http://gqmpeg.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.2:2
	media-sound/vorbis-tools
	media-sound/mpg123"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_configure() {
	econf $(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog FAQ NEWS README SKIN-SPECS* TODO
}
