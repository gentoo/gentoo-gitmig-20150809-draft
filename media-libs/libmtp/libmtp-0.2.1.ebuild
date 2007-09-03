# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmtp/libmtp-0.2.1.ebuild,v 1.1 2007/09/03 19:41:47 chainsaw Exp $

DESCRIPTION="An implementation of Microsoft's Media Transfer Protocol (MTP)."
HOMEPAGE="http://libmtp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc examples"

RDEPEND=">=dev-libs/libusb-0.1.7
	sys-libs/ncurses
	sys-libs/zlib"

DEPEND="doc? ( app-doc/doxygen )
	${RDEPEND}"

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

pkg_postinst() {
	elog "Please note that the ABI for libmtp has changed. Please run revdep-rebuild to automatically recompile any affected programs."
}
