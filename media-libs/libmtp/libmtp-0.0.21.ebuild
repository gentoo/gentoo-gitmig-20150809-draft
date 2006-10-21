# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmtp/libmtp-0.0.21.ebuild,v 1.1 2006/10/21 19:54:56 tcort Exp $

inherit eutils

DESCRIPTION="An implementation of Microsoft's Media Transfer Protocol (MTP)."
HOMEPAGE="http://libmtp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND=">=dev-libs/libusb-0.1.7
	sys-libs/ncurses
	sys-libs/zlib"

DEPEND="doc? ( app-doc/doxygen )
	${RDEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}"/libmtp-0.0.16-udev_perm.patch
}

src_compile() {
	econf --enable-hotplugging || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO

	insinto /etc/udev/rules.d
	newins libmtp.rules 65-mtp.rules

	if use examples ; then
		docinto examples
		dodoc examples/*.{c,h,sh}
	fi
}
