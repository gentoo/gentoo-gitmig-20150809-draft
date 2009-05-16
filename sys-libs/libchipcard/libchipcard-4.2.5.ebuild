# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libchipcard/libchipcard-4.2.5.ebuild,v 1.2 2009/05/16 09:23:37 robbat2 Exp $

DESCRIPTION="Libchipcard is a library for easy access to chip cards via chip card readers (terminals)."
HOMEPAGE="http://www.libchipcard.de"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

IUSE="debug doc ssl usb"

DEPEND=">=sys-libs/gwenhywfar-3.5.0
	ssl? ( >=dev-libs/openssl-0.9.6b )
	usb? ( =virtual/libusb-0* )
	sys-apps/hal"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}"

src_compile() {
	econf \
	`use_enable ssl` \
	`use_enable debug` \
	`use_enable usb libusb` \
	--localstatedir=/var \
	--enable-pcsc || die

	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	keepdir /var/log/chipcard \
		/var/lib/chipcardd/newcerts \
		/usr/lib/chipcardd/server/lowlevel

	doinitd "${FILESDIR}/chipcardd4" || die

	dodoc AUTHORS ChangeLog README doc/CERTIFICATES doc/CONFIG doc/IPCCOMMANDS || die
	if use doc ; then
		docinto tutorials
		dodoc tutorials/*.{c,h,xml} tutorials/README || die
	fi

	find "${D}" -name '*.la' -delete
}
