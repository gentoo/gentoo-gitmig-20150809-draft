# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/syslog-ng/syslog-ng-1.6.11.ebuild,v 1.4 2006/10/21 22:49:40 vapier Exp $

inherit fixheadtails

DESCRIPTION="syslog replacement with advanced filtering features"
HOMEPAGE="http://www.balabit.com/products/syslog_ng/"
SRC_URI="http://www.balabit.com/downloads/syslog-ng/${PV%.*}/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 arm ~hppa ia64 ~mips ~ppc ~ppc64 s390 sh ~sparc ~x86"
IUSE="hardened selinux static tcpd"

RDEPEND=">=dev-libs/libol-0.3.16
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51
	sys-devel/flex"
PROVIDE="virtual/logger"

src_unpack() {
	unpack ${A}
	cd "${S}"
	ht_fix_file configure
	# fix for bugs #104538 and bug #104475
	sed -i \
		-e "s:utils/::" \
		-e "s:--local-:--:" \
		configure \
		|| die "sed failed"
	cd "${S}/doc/sgml"
	tar xzf syslog-ng.html.tar.gz || die "tar failed"
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		--with-libol=/usr/bin \
		$(use_enable static full-static) \
		$(use_enable tcpd tcp-wrapper) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog INSTALL NEWS PORTS README \
		doc/{syslog-ng.conf.sample,syslog-ng.conf.demo,stresstest.sh} \
		doc/sgml/syslog-ng.txt contrib/syslog2ng "${FILESDIR}/syslog-ng.conf."*
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
