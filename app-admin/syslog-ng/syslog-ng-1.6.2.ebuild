# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/syslog-ng/syslog-ng-1.6.2.ebuild,v 1.6 2004/06/24 21:39:18 agriffis Exp $

# The release candidates are named syslog-ng-1.6.0rc1 for example
MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="syslog replacement with advanced filtering features"
HOMEPAGE="http://www.balabit.com/products/syslog_ng/"
SRC_URI="http://www.balabit.com/downloads/syslog-ng/${PV%.*}/src/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64 ppc64 s390"
IUSE="tcpd"

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
	econf \
		$(use_enable tcpd tcp-wrapper) || die "econf failed"
	emake prefix="${D}/usr" all || die "emake failed"
}

src_install() {
	einstall || die

	prepallman

	dodoc AUTHORS ChangeLog INSTALL NEWS PORTS README \
		doc/{syslog-ng.conf.sample,syslog-ng.conf.demo,stresstest.sh} \
		doc/sgml/{syslog-ng.dvi,syslog-ng.ps,syslog-ng.sgml,syslog-ng.txt} \
		contrib/syslog2ng
	dohtml doc/sgml/syslog-ng.html/*

	# Install default configuration
	insinto /etc/syslog-ng
	newins "${FILESDIR}/syslog-ng.conf.gentoo" syslog-ng.conf

	# Install snippet for logrotate, which may or may not be installed
	insinto /etc/logrotate.d
	newins "${FILESDIR}/syslog-ng.logrotate" syslog-ng

	exeinto /etc/init.d
	newexe "${FILESDIR}/syslog-ng.rc6" syslog-ng
}
