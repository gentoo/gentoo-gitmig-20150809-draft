# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lash/lash-0.5.1.ebuild,v 1.3 2006/09/04 09:12:34 blubb Exp $

inherit eutils

IUSE=""

DESCRIPTION="LASH Audio Session Handler"
HOMEPAGE="http://www.nongnu.org/lash/"
SRC_URI="http://download.savannah.gnu.org/releases/lash/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-libs/alsa-lib
	media-sound/jack-audio-connection-kit
	dev-libs/libxml2
	>=x11-libs/gtk+-2.0"

src_compile() {
	econf --disable-serv-inst || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	# Add to /etc/services
	if ! grep -q ^lash /etc/services; then
		dodir /etc
		insinto /etc
		doins /etc/services
		echo -e "\nlash\t\t14541/tcp\t\t\t# LASH client/server protocol" >> ${D}/etc/services
	fi

	dodoc AUTHORS ChangeLog NEWS README TODO
}
