# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mangler/mangler-1.0.1.ebuild,v 1.1 2010/01/05 04:35:47 yngwin Exp $

EAPI="2"

MY_P="${P/_/}"
DESCRIPTION="Open source VOIP client capable of connecting to Ventrilo 3.x servers"
HOMEPAGE="http://www.mangler.org/"
SRC_URI="http://www.mangler.org/downloads/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-cpp/gtkmm:2.4
	media-libs/speex
	media-sound/gsm
	media-sound/pulseaudio"
DEPEND="${DEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_install() {
	emake DESTDIR="${D}" install || die
}
