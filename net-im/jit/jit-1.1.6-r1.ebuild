# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jit/jit-1.1.6-r1.ebuild,v 1.2 2004/02/17 21:36:14 humpback Exp $

DESCRIPTION="ICQ transport for WPjabber/Jabberd"
HOMEPAGE="http://jit.jabberstudio.org/"
SRC_URI="http://www.jabberstudio.org/files/jit/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

IUSE=""

KEYWORDS="x86"

DEPEND=""
RDEPEND=">=net-im/jabberd-1.4.3"


src_compile() {
	./configure
	emake || die
	cp ${S}/jabberd/jabberd ${S}/jabberd/jit-wpjabber
}

src_install() {
	dodir /etc/jabber /usr/lib/jabber /usr/sbin
	insinto /usr/lib/wpjabber
	doins jit/jit.so
	exeinto /usr/sbin
	doexe jabberd/jit-wpjabber
	insinto /etc/jabber
	doins ${FILESDIR}/jit.xml
	fowners jabber:jabber /usr/sbin/jit-wpjabber
	fperms o-rwx /etc/jabber
	fperms u+xs /usr/sbin/jit-wpjabber
	dodoc ${FILESDIR}/README.Gentoo
}

pkg_postinst() {

	einfo
	einfo "Please read /usr/share/doc/${P}/README.Gentoo.gz"
	einfo

}
