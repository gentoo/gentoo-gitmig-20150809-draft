# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/swh-plugins/swh-plugins-0.4.11.ebuild,v 1.1 2004/11/21 19:10:42 fvdpol Exp $

inherit flag-o-matic eutils

IUSE=""
DESCRIPTION="Large collection of LADSPA audio plugins/effects"
HOMEPAGE="http://plugin.org.uk"
SRC_URI="http://plugin.org.uk/releases/${PV}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND="media-libs/ladspa-sdk
	dev-libs/fftw
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A} || die

	use amd64 && append-flags -fPIC
	use ppc && append-flags -fPIC

	cd ${S}
	sed -i '/MACHINE=/s/.*/MACHINE=""/' configure
}


src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING README TODO || die
}

pkg_postinst() {
	ewarn "WARNING: You have to be careful when using the	"
	ewarn "swh plugins. Be sure to lower your sound volume	"
	ewarn "and then play around a bit with the plugins so	"
	ewarn "you get a feeling for it. Otherwise your speakers"
	ewarn "won't like that.									"
}
