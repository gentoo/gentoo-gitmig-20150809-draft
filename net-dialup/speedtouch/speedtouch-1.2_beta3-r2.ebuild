# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/speedtouch/speedtouch-1.2_beta3-r2.ebuild,v 1.1 2003/12/25 16:53:18 twp Exp $

inherit flag-o-matic
filter-flags -mpowerpc-gfxopt -mpowerpc-gpopt

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="GPL Driver for the Alcatel Speedtouch USB under *nix"
HOMEPAGE="http://speedtouch.sf.net/"
SRC_URI="mirror://sourceforge/speedtouch/${MY_P}.tar.bz2"

IUSE="static debug"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~hppa ~amd64"

DEPEND=""
RDEPEND=">=net-dialup/ppp-2.4.1"

src_compile() {
	use debug && myconf="--enable-debug"
	use static && myconf="${myconf} --enable-static"

	econf --enable-syslog  \
		${myconf} || die "./configure failed"

	emake || die "make failed"
}

src_install () {
	einstall || die

	# twp 2003-12-25 install *.html correctly
	find ${D}/usr/share/doc/speedtouch/ -type f -name '*.html' | xargs dohtml
	find ${D}/usr/share/doc/speedtouch/ -type f -name '*.html' | xargs rm
	echo $(find ${D}/usr/share/doc/speedtouch/ -type f) | xargs dodoc
	rm -rf ${D}/usr/share/doc/speedtouch/
	dodoc AUTHORS COPYING ChangeLog INSTALL TODO VERSION

	exeinto /etc/init.d ; newexe ${FILESDIR}/speedtouch.rc6 speedtouch

	insinto /etc/conf.d ; newins ${FILESDIR}/speedtouch.confd speedtouch

	insopts -m 600 ; insinto /etc/ppp/peers ; doins ${FILESDIR}/adsl.sample

	dosbin doc-linux/adsl-conf-pppd
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
