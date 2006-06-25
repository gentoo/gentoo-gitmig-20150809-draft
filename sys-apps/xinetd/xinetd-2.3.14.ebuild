# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/xinetd/xinetd-2.3.14.ebuild,v 1.9 2006/06/25 11:02:00 dertobi123 Exp $

inherit eutils

DESCRIPTION="powerful replacement for inetd"
HOMEPAGE="http://www.xinetd.org/"
SRC_URI="http://www.xinetd.org/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="perl tcpd"

DEPEND="tcpd? ( >=sys-apps/tcp-wrappers-7.6-r2 )"
RDEPEND="${DEPEND}
	perl? ( dev-lang/perl )"
PROVIDE="virtual/inetd"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-DESTDIR.patch
	epatch "${FILESDIR}"/${P}-install-contrib.patch
	epatch "${FILESDIR}"/${P}-config.patch
}

src_compile() {
	econf \
		$(use_with tcpd libwrap) \
		--with-loadavg \
		|| die "econf failed"
	emake || die "Failed to compile"
}

src_install() {
	make install install-contrib DESTDIR="${D}" || die "failed install"
	use perl || rm -f "${D}"/usr/sbin/xconv.pl

	newinitd "${FILESDIR}"/xinetd.rc6 xinetd || die
	newconfd "${FILESDIR}"/xinetd.confd xinetd || die

	newdoc contrib/xinetd.conf xinetd.conf.dist.sample
	dodoc AUDIT INSTALL README TODO CHANGELOG
}

pkg_postinst() {
	einfo "This ebuild introduces the /etc/xinetd.d includedir with a default"
	einfo "/etc/xinetd.conf file. Check your config files if you're upgrading from an older"
	einfo "ebuild version. You should browse /etc/xinetd.conf and the files in /etc/xinetd.d."
	ewarn
	ewarn "PLEASE NOTE: Everything is off by default with access restricted to localhost."
	ewarn
	einfo "Check /etc/conf.d/xinetd for the startup options."
	echo ""
}
