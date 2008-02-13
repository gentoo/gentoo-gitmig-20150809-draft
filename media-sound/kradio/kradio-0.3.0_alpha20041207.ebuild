# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kradio/kradio-0.3.0_alpha20041207.ebuild,v 1.3 2008/02/13 10:41:11 phosphan Exp $

inherit kde

S="${WORKDIR}/${PN}"

DESCRIPTION="kradio is a radio tuner application for KDE"
HOMEPAGE="http://kradio.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
		http://dev.gentoo.org/~phosphan/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="lirc"

DEPEND="lirc? ( app-misc/lirc )
	media-libs/libsndfile"
need-kde 3

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-gcc.patch"
}
