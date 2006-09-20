# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

DESCRIPTION="Gadu-Gadu transport for Jabber"
HOMEPAGE="http://jggtrans.jajcus.net/"
SRC_URI="http://jggtrans.jajcus.net/downloads/jggtrans-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-im/jabberd
	>=dev-libs/glib-2.6.4
	net-dns/libidn"

S="${WORKDIR}/jggtrans-${PV}"

src_install() {

	make DESTDIR=${D} install || die "install failed"

	newinitd ${FILESDIR}/jggtrans-${PVR} jggtrans

	insinto /etc/jabber
	doins jggtrans.xml

	dodoc AUTHORS ChangeLog README README.Pl NEWS

}
