# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/syslog-ng/syslog-ng-1.6.6.ebuild,v 1.3 2005/04/05 22:59:31 mr_bones_ Exp $

DESCRIPTION="syslog replacement with advanced filtering features"
HOMEPAGE="http://www.balabit.com/products/syslog_ng/"
SRC_URI="http://www.balabit.com/downloads/syslog-ng/${PV%.*}/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="hardened static tcpd"

RDEPEND=">=dev-libs/libol-0.3.14
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51
	sys-devel/flex"
PROVIDE="virtual/logger"

src_unpack() {
	unpack ${A}
	cd "${S}/doc/sgml"
	tar xzf syslog-ng.html.tar.gz || die "tar failed"
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static full-static) \
		$(use_enable tcpd tcp-wrapper) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	prepallman

	dodoc AUTHORS ChangeLog INSTALL NEWS PORTS README \
		doc/{syslog-ng.conf.sample,syslog-ng.conf.demo,stresstest.sh} \
		doc/sgml/{syslog-ng.dvi,syslog-ng.ps,syslog-ng.sgml,syslog-ng.txt} \
		contrib/syslog2ng "${FILESDIR}/syslog-ng.conf.debian"
	dohtml doc/sgml/syslog-ng.html/*

	# Install default configuration
	insinto /etc/syslog-ng
	if use hardened || use selinux ; then
		newins "${FILESDIR}/syslog-ng.conf.gentoo.hardened" syslog-ng.conf
	else
		newins "${FILESDIR}/syslog-ng.conf.gentoo" syslog-ng.conf
	fi

	# Install snippet for logrotate, which may or may not be installed
	insinto /etc/logrotate.d
	newins "${FILESDIR}/syslog-ng.logrotate" syslog-ng

	newinitd "${FILESDIR}/syslog-ng.rc6" syslog-ng
}
