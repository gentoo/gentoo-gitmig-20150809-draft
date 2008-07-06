# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/g15stats/g15stats-1.0.ebuild,v 1.1 2008/07/06 11:21:48 loki_val Exp $

DESCRIPTION="A simple message/alert client for G15daemon"
HOMEPAGE="http://g15daemon.sourceforge.net/"
SRC_URI="mirror://sourceforge/g15daemon/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=app-misc/g15daemon-1.9.0
	dev-libs/libg15
	dev-libs/libg15render
	sys-libs/zlib
	gnome-base/libgtop"

DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_compile() {
	export CPPFLAGS=$CFLAGS
	econf || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	rm "$D"/usr/share/doc/${P}/{COPYING,NEWS}

	newconfd "${FILESDIR}/${P}.confd" ${PN}
	newinitd "${FILESDIR}/${P}.initd" ${PN}

	prepalldocs
}

pkg_postinst() {
	elog "Remember to set the interface you want monitored in"
	elog "/etc/conf.d/g15stats"
}
