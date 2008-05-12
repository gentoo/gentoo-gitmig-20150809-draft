# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gg-transport/gg-transport-2.2.2-r1.ebuild,v 1.8 2008/05/12 08:44:55 nelchael Exp $

DESCRIPTION="Gadu-Gadu transport for Jabber"
HOMEPAGE="http://jggtrans.jajcus.net/"
SRC_URI="http://jggtrans.jajcus.net/downloads/jggtrans-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND=">=net-im/jabber-base-0.01
	>=dev-libs/glib-2.6.4
	net-dns/libidn"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/jggtrans-${PV}"

src_install() {

	make DESTDIR="${D}" install || die "install failed"

	keepdir /var/spool/jabber/gg
	keepdir /var/run/jabber
	keepdir /var/log/jabber
	fowners jabber:jabber /var/spool/jabber/gg
	fowners jabber:jabber /var/run/jabber
	fowners jabber:jabber /var/log/jabber

	newinitd "${FILESDIR}/jggtrans-${PVR}" jggtrans

	insinto /etc/jabber
	doins jggtrans.xml

	sed -i \
		-e 's,/var/lib/jabber/spool/gg.localhost/,/var/spool/jabber/gg/,' \
		-e 's,/var/lib/jabber/ggtrans.pid,/var/run/jabber/jggtrans.pid,' \
		-e 's,/tmp/ggtrans.log,/var/log/jabber/jggtrans.log,' \
		"${D}/etc/jabber/jggtrans.xml"

	dodoc AUTHORS ChangeLog README README.Pl NEWS

}
