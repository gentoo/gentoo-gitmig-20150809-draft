# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/freenet6/freenet6-0.9.7.ebuild,v 1.1 2003/05/28 18:36:41 latexer Exp $

DESCRIPTION="Client to configure an IPv6 tunnel to freenet6"
HOMEPAGE="http://www.freenet6.net/"
SRC_URI="mirror://gentoo/${P}.tgz"

LICENSE="VPL-1.0"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
DEPEND=""


src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/freenet6-0.9.2.diff || die "Failed to patch"

	mv -f src/Makefile ${T}
	sed "s:gcc -g -I\$(INC) -Wall:${CC} -I\$(INC) ${CFLAGS}:" \
		${T}/Makefile > src/Makefile
}

src_compile() {
	emake all target=linux || die "Build Failed"
}

src_install() {
	dosbin bin/tspc

	insopts -m 600
	insinto /etc/freenet6
	doins ${FILESDIR}/tspc.conf
	exeinto /etc/freenet6/template
	doexe template/{linux,checktunnel}.sh

	dodoc CONTRIB.txt LEGAL LEGAL.html README
	doman man/{man5/tspc.conf.5,man8/tspc.8}

	exeinto /etc/init.d
	newexe ${FILESDIR}/tspc.rc tspc
}

pkg_postinst() {
	einfo "The freenet6 ebuild installs an init script named 'tspc'"
	einfo "to coincide with the name of the client binary installed"
	einfo "To add support for a freenet6 connection at startup, do"
	einfo ""
	einfo "# rc-update add tspc default"
}
