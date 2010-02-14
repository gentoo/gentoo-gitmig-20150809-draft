# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libosip/libosip-3.3.0.ebuild,v 1.2 2010/02/14 20:42:25 pva Exp $

EAPI="2"

inherit eutils autotools

MY_PV=${PV%.?}-${PV##*.}
MY_PV=${PV}
MY_P=${PN}2-${MY_PV}
DESCRIPTION="a simple way to support the Session Initiation Protocol"
HOMEPAGE="http://www.gnu.org/software/osip/"
SRC_URI="mirror://gnu/osip/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="test"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}/${P}-out-source-build.patch"
	AT_M4DIR="scripts" eautoreconf
}

src_configure() {
	econf --enable-mt \
		$(use_enable test)
}

src_install() {
	emake DESTDIR="${D}" install || die "Failed to install"
	dodoc AUTHORS ChangeLog FEATURES HISTORY README NEWS TODO || die
}
