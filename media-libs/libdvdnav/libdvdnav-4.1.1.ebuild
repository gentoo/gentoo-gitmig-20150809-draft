# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdnav/libdvdnav-4.1.1.ebuild,v 1.1 2007/11/02 02:13:46 beandog Exp $

WANT_AUTOCONF="2.5"

inherit eutils autotools multilib

DESCRIPTION="Library for DVD navigation tools"
HOMEPAGE="http://mplayerhq.hu/"
SRC_URI="mirror://mplayer/releases/dvdnav/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="debug"

RDEPEND="media-libs/libdvdread"
DEPEND="${RDEPEND}"

src_compile() {
	./autogen.sh || die "autogen died"
	econf $(use_enable debug) || die "econf died"
	emake || die "emake died"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install died"
	dodoc AUTHORS DEVELOPMENT-POLICY.txt ChangeLog TODO \
		doc/dvd_structures
}
