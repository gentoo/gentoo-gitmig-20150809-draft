# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libvformat/libvformat-1.13-r1.ebuild,v 1.4 2009/05/14 19:13:27 maekke Exp $

inherit eutils autotools

DESCRIPTION="Library to read and write vcard files"
HOMEPAGE="http://sourceforge.net/projects/vformat/"
SRC_URI="mirror://debian/pool/main/libv/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/libv/${PN}/${PN}_${PV}-4.diff.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ~ppc x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${P}.orig"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${DISTDIR}/${PN}_${PV}-4.diff.gz" || die "epatch failed"

	# Patch for not installing documentation, because that needs c2man
	epatch "${FILESDIR}/${PN}-nodoc.patch" || die "epatch failed"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}
