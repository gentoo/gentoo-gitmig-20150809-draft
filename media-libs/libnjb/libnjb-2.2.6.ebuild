# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libnjb/libnjb-2.2.6.ebuild,v 1.5 2008/07/05 11:51:40 drac Exp $

inherit libtool

DESCRIPTION="a C library and API for communicating with the Creative Nomad JukeBox digital audio player."
HOMEPAGE="http://libnjb.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-libs/libusb-0.1.7"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:SUBDIRS = src sample doc:SUBDIRS = src doc:" \
		Makefile.in || die "sed failed."
	elibtoolize
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."

	dodoc AUTHORS ChangeLog* FAQ HACKING README

	insinto /etc/udev/rules.d
	newins "${FILESDIR}"/${PN}.rules 80-${PN}.rules

	insinto /usr/share/hal/fdi/information/20thirdparty
	newins ${PN}.fdi 10-${PN}.fdi
}
