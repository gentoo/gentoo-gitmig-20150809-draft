# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/syslog-ng/syslog-ng-1.5.26-r1.ebuild,v 1.3 2003/06/29 15:24:07 aliz Exp $

DESCRIPTION="syslog replacement with advanced filtering features"
SRC_URI="http://www.balabit.hu/downloads/syslog-ng/1.5/${P}.tar.gz"
HOMEPAGE="http://www.balabit.hu/en/downloads/syslog-ng/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
IUSE="tcpd"

DEPEND=">=dev-libs/libol-0.3.9
	sys-devel/flex
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"

src_compile() {
	local myconf
	use tcpd && myconf="--enable-tcp-wrapper"
	econf ${myconf}

	emake prefix=${D}/usr all || die "compile problem"
}

src_install() {
	einstall
	rm -rf ${D}/usr/share/man

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS PORTS README
	dodoc doc/{syslog-ng.conf.sample,syslog-ng.conf.demo,stresstest.sh}
	doman doc/{syslog-ng.8,syslog-ng.conf.5}
	dodoc doc/sgml/{syslog-ng.dvi,syslog-ng.html.tar.gz,syslog-ng.ps,syslog-ng.sgml,syslog-ng.txt}

	insinto /usr/share/doc/${PF}
	doins contrib/syslog2ng

	dodir /etc/syslog-ng
	insinto /etc/syslog-ng
	doins ${FILESDIR}/syslog-ng.conf.sample

	exeinto /etc/init.d
	newexe ${FILESDIR}/syslog-ng.rc6 syslog-ng
}

pkg_postinst() {
	einfo "A sample configuration file can be found in /etc/syslog-ng."
    einfo "To convert your existing syslog.conf for use with syslog-ng,"
    einfo "use the syslog2ng script in /usr/share/doc/${PF}."
}
