# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ladcca/ladcca-0.4.0.ebuild,v 1.9 2004/09/22 22:21:56 eradicator Exp $

IUSE="alsa"

DESCRIPTION="Linux Audio Developer's Configuration and Connection API (LADCCA)"
HOMEPAGE="http://pkl.net/~node/ladcca.html"
SRC_URI="http://pkl.net/~node/software/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64 ~sparc"

DEPEND="alsa? ( media-libs/alsa-lib )
	media-sound/jack-audio-connection-kit
	>=x11-libs/gtk+-2.0"

src_compile() {
	econf --disable-serv-inst || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	# Add to /etc/services
	if ! grep -q ^ladcca /etc/services; then
		dodir /etc
		insinto /etc
		doins /etc/services
		echo -e "\nladcca\t\t14541/tcp\t\t\t# LADCCA client/server protocol" >> ${D}/etc/services
	fi

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
