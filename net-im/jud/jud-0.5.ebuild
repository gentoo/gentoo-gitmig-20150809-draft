# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jud/jud-0.5.ebuild,v 1.5 2004/03/28 05:19:59 weeve Exp $

DESCRIPTION="Open Source Jabber User Directory"
HOMEPAGE="http://jud.jabberstudio.org/"
SRC_URI="http://jud.jabberstudio.org/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"
SLOT="0"

DEPEND=">=net-im/jabberd-1.4.3"
S=${WORKDIR}/${PN}-ansi-c

src_unpack() {
		unpack ${A}
		cd ${S}
		epatch ${FILESDIR}/jud-makefile.patch
}

src_compile() {
		emake || die
}

src_install() {
		 dodir /etc/jabber /usr/lib/jabberd
		 insinto /usr/lib/jabberd
		 doins jud.so
		 insinto /etc/jabber
		 dodoc README ChangeLog ${FILESDIR}/README.Gentoo
}

pkg_postinst() {
	einfo
	einfo "Please read /usr/share/doc/${P}/README.Gentoo.gz"
	einfo
}
