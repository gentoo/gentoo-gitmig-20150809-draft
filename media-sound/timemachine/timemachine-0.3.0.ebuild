# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/timemachine/timemachine-0.3.0.ebuild,v 1.5 2008/01/13 13:14:27 aballier Exp $

IUSE="ladcca"

inherit flag-o-matic eutils

DESCRIPTION="JACK client record button remembering the last 10 seconds when pressed."
HOMEPAGE="http://plugin.org.uk/timemachine/"
SRC_URI="http://plugin.org.uk/timemachine/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

RDEPEND=">=media-sound/jack-audio-connection-kit-0.80.0
	>=x11-libs/gtk+-2.2.4-r1
	>=media-libs/libsndfile-1.0.5
	ladcca? ( >=media-libs/ladcca-0.4.0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf `use_enable ladcca` || die
	make || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog
}
