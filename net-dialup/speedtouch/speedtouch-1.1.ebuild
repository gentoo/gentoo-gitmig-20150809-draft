# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/speedtouch/speedtouch-1.1.ebuild,v 1.4 2003/04/15 21:19:15 taviso Exp $

DESCRIPTION="GPL Driver for the Alcatel Speedtouch USB under *nix"
SRC_URI="mirror://sourceforge/speedtouch/${P}.tar.bz2"
HOMEPAGE="http://speedtouch.sf.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~alpha"

DEPEND=""
RDEPEND=">=net-dialup/ppp-2.4.1"

src_compile() {
	local myconf
	
	[ "${DEBUG:+set}" = set ] && myconf="--enable-debug"
	use static && myconf="${myconf} --enable-static"

	sed 's/^C$/#&/' < configure > configure.new
	mv --force configure.new configure && chmod u+x configure

	econf 	--enable-syslog  \
		${myconf} || die "./configure failed"

	sed '90,104d' < Makefile > Makefile.new
	mv --force Makefile.new Makefile
	emake || die "make failed"
}

src_install () {
	einstall || die

	echo $(find ${D}/usr/share/doc/speedtouch/ -type f) | xargs dodoc
	rm -rf ${D}/usr/share/doc/speedtouch/
	dodoc AUTHORS COPYING ChangeLog INSTALL TODO VERSION
	rm -r ${D}/etc/init.d/speedtouch
	exeinto /etc/init.d ; newexe ${FILESDIR}/speedtouch.rc6 speedtouch
	insinto /etc/conf.d ; newins ${FILESDIR}/speedtouch.confd speedtouch
	insopts -m 600 ; insinto /etc/ppp/peers ; doins ${FILESDIR}/adsl.sample
}

pkg_postinst() {
	echo ""
	ewarn "Make sure you have kernel support for USB, HDCL and PPP"
	ewarn "NB: kernels >= 2.4.18 include the hdlc patch"
	echo ""
	ewarn "Read and subscribe vendor's licence to download the microcode"
	ewarn "You can get it from: "
	ewarn "  1) vendor's site: http://www.speedtouchdsl.com/dvrreg_lx.htm"
	ewarn "  2) a windows system: c:\windows\system\alcaudsl.sys"
	ewarn "  3) the CD provided: X:\Driver\alcaudsl.sys"
	ewarn "Then you should set its path in the /etc/conf.d/speedtouch file"
	ewarn "edit and rename 'adsl.sample' to 'adsl' in /etc/ppp/peers/adsl and"
	ewarn "bring up your adsl line using the /etc/init.d/speedtouch script"
	echo ""
	einfo "More info in the documentation in /usr/share/doc/${P}"
	echo ""
}
