# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/xinetd/xinetd-2.3.13.ebuild,v 1.14 2005/03/22 02:49:36 vapier Exp $

inherit eutils

DESCRIPTION="powerful replacement for inetd"
HOMEPAGE="http://www.xinetd.org/"
SRC_URI="http://www.xinetd.org/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="tcpd"

DEPEND="tcpd? ( >=sys-apps/tcp-wrappers-7.6-r2 )"
RDEPEND="${DEPEND}
	dev-lang/perl"
PROVIDE="virtual/inetd"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc4.patch
}

src_compile() {
	local myconf
	use tcpd && myconf="--with-libwrap"
	econf --with-loadavg ${myconf} || die "econf failed"

	# Fix CFLAGS
	sed -i -e "/^CFLAGS/s/+=/=/" Makefile
	emake || die "Failed to compile"
}

src_install() {
	into /usr ; dosbin xinetd/xinetd xinetd/itox || die
	exeinto /usr/sbin ; doexe xinetd/xconv.pl

	newman xinetd/xinetd.conf.man xinetd.conf.5
	newman xinetd/xinetd.log.man xinetd.log.8
	newman xinetd/xinetd.man xinetd.8
	doman xinetd/itox.8

	newdoc xinetd/sample.conf xinetd.conf.dist.sample
	newdoc ${FILESDIR}/xinetd.conf xinetd.conf.default || die
	dodoc AUDIT INSTALL README TODO CHANGELOG COPYRIGHT

	insinto /etc/xinetd.d ; doins ${FILESDIR}/etc.xinetd.d/* || die
	exeinto /etc/init.d ; newexe ${FILESDIR}/xinetd.rc6 xinetd || die
	insinto /etc/conf.d ; newins ${FILESDIR}/xinetd.confd xinetd || die
	insinto /etc ; doins ${FILESDIR}/xinetd.conf || die
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
