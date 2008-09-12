# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/powerman/powerman-2.2.ebuild,v 1.1 2008/09/12 18:14:52 weaver Exp $

EAPI="1"

DESCRIPTION="RPC/PDU control and monitoring service for data center or compute cluster power management"
HOMEPAGE="http://powerman.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+httppower +genders"
DEPEND="sys-devel/bison"
RDEPEND=">=sys-libs/freeipmi-0.2.3"

src_compile() {
	econf \
		$(use_with httppower) \
		$(use_with genders)
	emake || die
}

src_install() {
	emake DESTDIR="${D}" -j1 install || die
	rm -f "${D}/etc/init.d/powerman"
	doinitd "${FILESDIR}/powerman" || die
	dodoc AUTHORS ChangeLog DISCLAIMER NEWS TODO
}
