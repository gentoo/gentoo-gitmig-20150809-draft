# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/g15stats/g15stats-1.9.7.ebuild,v 1.1 2011/08/03 08:11:00 robbat2 Exp $

EAPI=4

DESCRIPTION="CPU, memory, swap, network stats for G15 Keyboard"
HOMEPAGE="http://g15daemon.sourceforge.net/"
SRC_URI="mirror://sourceforge/g15daemon/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-misc/g15daemon-1.9.0
	dev-libs/libg15
	dev-libs/libg15render
	sys-libs/zlib
	gnome-base/libgtop"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sh autogen.sh
}

src_configure() {
	export CPPFLAGS=$CFLAGS
	econf
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	rm "$D"/usr/share/doc/${P}/{COPYING,NEWS}

	newconfd "${FILESDIR}/${PN}-1.9.7.confd" ${PN}
	newinitd "${FILESDIR}/${PN}-1.9.7.initd" ${PN}
}

pkg_postinst() {
	elog "Remember to set the interface you want monitored in"
	elog "/etc/conf.d/g15stats"
}
