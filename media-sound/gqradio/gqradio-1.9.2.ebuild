# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gqradio/gqradio-1.9.2.ebuild,v 1.3 2007/08/19 07:42:35 drac Exp $

DESCRIPTION="An FM radio tuner app from the people who brought you GQmpeg."
HOMEPAGE="http://gqmpeg.sourceforge.net/radio.html"
SRC_URI="mirror://sourceforge/gqmpeg/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README SKIN-SPECS TODO
}
