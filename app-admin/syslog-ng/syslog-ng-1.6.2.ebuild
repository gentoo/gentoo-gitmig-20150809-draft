# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/syslog-ng/syslog-ng-1.6.2.ebuild,v 1.1 2004/02/15 01:11:37 agriffis Exp $

IUSE="tcpd"
# The release candidates are named syslog-ng-1.6.0rc1 for example
MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="syslog replacement with advanced filtering features"
SRC_URI="http://www.balabit.com/downloads/syslog-ng/${PV%.*}/src/${MY_P}.tar.gz"
HOMEPAGE="http://www.balabit.com/products/syslog_ng/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64 ~ppc64"

# I don't know if 0.3.13 is really required but why not?  It's the
# current version and I don't know if 0.3.9 is new enough.  
# (14 Feb 2004 agriffis)
RDEPEND=">=dev-libs/libol-0.3.13
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"
DEPEND="${RDEPEND}
	sys-devel/flex"

PROVIDE="virtual/logger"

src_unpack() {
	unpack ${A}
	cd ${S}/doc/sgml
	tar xzf syslog-ng.html.tar.gz
}

src_compile() {
	local myconf="$(use_enable tcpd tcp-wrapper)"
	econf ${myconf} || die "econf failed"
	emake prefix=${D}/usr all || die "emake failed"
}

src_install() {
	einstall || die

	prepallman

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS PORTS README
	dodoc doc/{syslog-ng.conf.sample,syslog-ng.conf.demo,stresstest.sh}
	dodoc doc/sgml/{syslog-ng.dvi,syslog-ng.ps,syslog-ng.sgml,syslog-ng.txt}
	dodoc contrib/syslog2ng
	dohtml doc/sgml/syslog-ng.html/*

	# Install default configuration
	dodir /etc/syslog-ng
	insinto /etc/syslog-ng
	newins ${FILESDIR}/syslog-ng.conf.gentoo syslog-ng.conf

	# Install snippet for logrotate, which may or may not be installed
	dodir /etc/logrotate.d
	insinto /etc/logrotate.d
	newins ${FILESDIR}/syslog-ng.logrotate syslog-ng

	exeinto /etc/init.d
	newexe ${FILESDIR}/syslog-ng.rc6 syslog-ng
}
