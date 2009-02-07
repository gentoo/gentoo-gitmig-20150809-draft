# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libjingle/libjingle-0.3.11-r1.ebuild,v 1.1 2009/02/07 05:17:53 darkside Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Google's jabber voice extension library modified by Tapioca"
HOMEPAGE="http://tapioca-voip.sourceforge.net/"
SRC_URI="mirror://sourceforge/tapioca-voip/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/openssl
	dev-libs/expat"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	# there is an error in configure.ac : CXXFLAGS are using CFLAGS
	# see bug #234012
	# patching directly configure to prevent executing autoconf
	sed -i -e 's/CXXFLAGS="$CFLAGS/CXXFLAGS="$CXXFLAGS/' configure \
		|| die "patching configure failed"

	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
