# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ifplugd/ifplugd-0.28-r5.ebuild,v 1.1 2006/04/06 12:23:08 uberlord Exp $

inherit eutils

DESCRIPTION="Brings up/down ethernet ports automatically with cable detection"
HOMEPAGE="http://0pointer.de/lennart/projects/ifplugd/"
SRC_URI="http://0pointer.de/lennart/projects/ifplugd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc"

DEPEND="dev-util/pkgconfig
	doc? ( www-client/lynx )
	>=dev-libs/libdaemon-0.5"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}/${P}-nlapi.diff"
}

src_compile() {
	econf $(use_enable doc lynx) \
		--with-initdir=/etc/init.d \
		--disable-xmltoman \
		--disable-subversion \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# Fix init.d configuration
	rm -rf "${D}/etc/ifplugd" "${D}/etc/init.d/${PN}"

	insinto /etc/conf.d ; newins "${FILESDIR}/${PN}.conf" "${PN}" || die
	exeinto /etc/init.d ; newexe "${FILESDIR}/${PN}.init" "${PN}" || die
	dodir "/etc/${PN}"
	exeinto "/etc/${PN}"
	newexe "${FILESDIR}/${PN}.action" "${PN}.action" || die

	cd "${S}/doc"
	dodoc README SUPPORTED_DRIVERS
	use doc && dohtml *.{html,css}
}
