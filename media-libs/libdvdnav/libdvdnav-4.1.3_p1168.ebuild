# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdnav/libdvdnav-4.1.3_p1168.ebuild,v 1.10 2010/08/10 16:27:42 jer Exp $

EAPI=2
WANT_AUTOCONF="2.5"
inherit eutils autotools multilib

DESCRIPTION="Library for DVD navigation tools"
HOMEPAGE="http://www.mplayerhq.hu/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=media-libs/libdvdread-4.1.3_p1168"
RDEPEND="$DEPEND"

src_prepare() {
	elibtoolize
	eautoreconf
}

src_install () {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS DEVELOPMENT-POLICY.txt ChangeLog TODO \
		doc/dvd_structures README || die
}
