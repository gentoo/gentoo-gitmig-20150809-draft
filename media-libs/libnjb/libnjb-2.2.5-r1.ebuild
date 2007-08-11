# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libnjb/libnjb-2.2.5-r1.ebuild,v 1.2 2007/08/11 08:57:57 drac Exp $

inherit eutils libtool

DESCRIPTION="libnjb is a C library and API for communicating with the Creative Nomad JukeBox digital audio player under BSD and Linux."
HOMEPAGE="http://libnjb.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"

DEPEND=">=dev-libs/libusb-0.1.7"

S="${WORKDIR}"/${PN}-${PV/_*}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:SUBDIRS = src sample doc:SUBDIRS = src doc:" Makefile.in
	elibtoolize
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dosym ${PN}.so /usr/$(get_libdir)/${PN}.so.0
	dodoc AUTHORS ChangeLog* FAQ HACKING README
	insinto /etc/udev/rules.d
	newins "${FILESDIR}"/${PN}.rules 80-${PN}.rules
}
