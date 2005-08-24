# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gg-transport/gg-transport-2.2.1.ebuild,v 1.1 2005/08/24 23:22:32 humpback Exp $

DESCRIPTION="GG transport for Jabber"
HOMEPAGE="http://jabberstudio.org/projects/jabber-gg-transport/project/view.php"
SRC_URI="http://files.jabberstudio.org/jabber-gg-transport/jabber-gg-transport-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=net-im/jabberd-1.4
	>=dev-libs/glib-2.6.4
	net-dns/libidn"

S="${WORKDIR}/jabber-gg-transport-${PV}"

src_compile() {

	econf || die "econf failed"
	emake || die "emake failed"

}

src_install() {

	make DESTDIR=${D} install || die "install failed"

	dodoc ABOUT-NLS AUTHORS BUGS ChangeLog COPYING INSTALL INSTALL.Pl
	dodoc README README.Pl NEWS TODO

	exeinto /etc/init.d
	doexe ${FILESDIR}/jggtrans

	insinto /etc/jabber
	doins jggtrans.xml

}
