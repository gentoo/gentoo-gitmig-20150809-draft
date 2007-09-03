# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/speedtouch/speedtouch-1.3.1-r3.ebuild,v 1.10 2007/09/03 17:51:40 mrness Exp $

inherit flag-o-matic eutils autotools

MY_P=${P/_/-}

DESCRIPTION="GPL Driver for the Alcatel Speedtouch USB under *nix"
HOMEPAGE="http://speedtouch.sf.net/"
SRC_URI="mirror://sourceforge/speedtouch/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ppc x86"
IUSE="static"

DEPEND=""
RDEPEND=">=net-dialup/ppp-2.4.1
	!net-dialup/speedtouch-usb"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	# Patch to fix gcc-4.* compile error (bug 99759)
	epatch "${FILESDIR}/${P}-gcc4.patch"

	# Increase minlevel of reports in atm.c
	# At least one of the reports could affect performance due to call frequency
	sed -i -e 's/report(0/report(1/' "${S}/src/atm.c"

	# Remove stupid --enable debug option (bug 191118)
	epatch "${FILESDIR}/${P}-debug.patch"
	cd "${S}"
	eautoreconf
}

src_compile() {
	filter-flags -mpowerpc-gfxopt -mpowerpc-gpopt
	econf \
		--enable-syslog \
		$(use_enable static) || die "./configure failed"

	emake || die "make failed"
}

src_install() {
	einstall || die "make install failed"

	# twp 2003-12-25 install *.html correctly
	dohtml $(find "${D}/usr/share/doc/speedtouch/" -type f -name '*.html')
	rm $(find "${D}/usr/share/doc/speedtouch/" -type f -name '*.html')
	dodoc $(find "${D}/usr/share/doc/speedtouch/" -type f)
	rm -rf "${D}/usr/share/doc/speedtouch/"
	dodoc AUTHORS ChangeLog TODO VERSION

	rm -rf "${D}/usr/bin"
	rm -rf "${D}/usr/share/man/man1"

	newinitd "${FILESDIR}/speedtouch.initd" speedtouch
	newconfd "${FILESDIR}/speedtouch.confd" speedtouch

	insopts -m 600 ; insinto /etc/ppp/peers ; doins "${FILESDIR}/adsl.sample"

	dosbin doc-linux/adsl-conf-pppd

	# allows hotplug to modprobe the speedtch module automatically
	mv "${D}"/etc/hotplug/usb/speedtouch.usermap "${D}"/etc/hotplug/usb/speedtch.usermap
	exeinto /etc/hotplug/usb ; newexe "${FILESDIR}/speedtch-hotplug" speedtch
	rm "${D}"/etc/hotplug/usb/speedtouch
}

pkg_postinst() {
	echo
	ewarn "Make sure you have kernel support for USB, HDCL and PPP"
	ewarn "NB: kernels >= 2.4.18 include the hdlc patch"
	ewarn
	ewarn "Read and subscribe vendor's licence to download the microcode"
	ewarn "You can get it from:"
	ewarn "  1) vendor's site: http://www.speedtouchdsl.com/dvrreg_lx.htm"
	ewarn "  2) a windows system: c:\\\\windows\\\\system\\\\alcaudsl.sys"
	ewarn "  3) the CD provided: X:\\\\Driver\\\\alcaudsl.sys"
	ewarn "Then you should set its path in the /etc/conf.d/speedtouch file"
	ewarn "edit and rename 'adsl.sample' to 'adsl' in /etc/ppp/peers/adsl and"
	ewarn "bring up your adsl line using the /etc/init.d/speedtouch script"
	ewarn
	elog "More info in the documentation in /usr/share/doc/${PF}"
	elog
	elog "You need to pass -a /usr/share/speedtouch/boot.v123.bin to"
	elog "modem_run with this version. The URL for firmware is:"
	elog "http://www.speedtouchdsl.com/driver_upgrade_lx_3.0.1.2.htm"
	elog
	ewarn "This driver is obsoleted by the kernel-space driver, available"
	ewarn "in >=2.6.10 kernels. The firmware and installation instructions"
	ewarn "for this driver are available through net-dialup/speedtouch-usb."
	echo
}
