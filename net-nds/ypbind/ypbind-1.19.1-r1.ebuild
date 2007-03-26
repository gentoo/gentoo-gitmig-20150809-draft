# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/ypbind/ypbind-1.19.1-r1.ebuild,v 1.2 2007/03/26 07:58:34 antarus Exp $

MY_P=${PN}-mt-${PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Multithreaded NIS bind service (ypbind-mt)"
HOMEPAGE="http://www.linux-nis.org/nis/ypbind-mt/index.html"
SRC_URI="ftp://ftp.kernel.org/pub/linux/utils/net/NIS/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ~mips ppc ppc64 sparc x86"
IUSE="nls slp"

RDEPEND="slp? ( net-libs/openslp )
	net-nds/yp-tools
	net-nds/portmap"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	econf $(use_enable nls) $(use_enable slp)
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die

	dodoc AUTHORS ChangeLog README THANKS TODO

	insinto /etc
	newins etc/yp.conf yp.conf.example

	newconfd ${FILESDIR}/ypbind.confd-r1 ypbind
	newinitd ${FILESDIR}/ypbind.initd ypbind
}

pkg_postinst() {
	einfo "To complete setup, you will need to edit /etc/conf.d/ypbind."
	einfo "If you are using dhcpcd, be sure to add the -Y option to"
	einfo "dhcpcd_eth0 (or eth1, etc.) to keep dhcpcd from clobbering"
	einfo "/etc/yp.conf."
}
