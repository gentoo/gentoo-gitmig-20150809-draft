# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/xinetd/xinetd-2.3.9.ebuild,v 1.8 2003/03/30 21:29:31 joker Exp $

DESCRIPTION="Xinetd is a powerful replacement for inetd, with advanced features"
HOMEPAGE="http://www.xinetd.org"
SRC_URI="http://www.xinetd.org/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ~ppc sparc alpha"

DEPEND="virtual/glibc 
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r2 )"
RDEPEND="${DEPEND} dev-lang/perl"

PROVIDE="virtual/inetd"

src_compile() {
	local myconf
	use tcpd && myconf="--with-libwrap"

	# the --with-inet6 is now obsolete. Services will default to IPv4 unless configured otherwise.

	econf --with-loadavg ${myconf}

	# Fix CFLAGS
	sed "/^CFLAGS/s/+=/=/" < Makefile > makefile
	mv --force makefile Makefile

	emake || die "Failed to compile"
}

src_install() {
	into /usr ; dosbin xinetd/xinetd xinetd/itox
	exeinto /usr/sbin ; doexe xinetd/xconv.pl

	newman xinetd/xinetd.conf.man xinetd.conf.5
	newman xinetd/xinetd.log.man xinetd.log.8
	newman xinetd/xinetd.man xinetd.8
	doman xinetd/itox.8
	
	newdoc xinetd/sample.conf xinetd.conf.dist.sample
	newdoc ${FILESDIR}/${PV}/xinetd.conf xinetd.conf.default
	dodoc AUDIT INSTALL README TODO xinetd/{CHANGELOG,COPYRIGHT}

	insinto /etc/xinetd.d ; doins ${FILESDIR}/${PV}/etc.xinetd.d/*
	exeinto /etc/init.d ; newexe ${FILESDIR}/${PV}/xinetd.rc6 xinetd
	insinto /etc/conf.d ; newins ${FILESDIR}/${PV}/xinetd.confd xinetd
	insinto /etc ; doins ${FILESDIR}/${PV}/xinetd.conf
}

pkg_postinst(){
	einfo "This ebuild introduces the /etc/xinetd.d includedir with a default"
	einfo "/etc/xinetd.conf file. Check your config files if you're upgrading from an older"
	einfo "ebuild version. You should browse /etc/xinetd.conf and the files in /etc/xinetd.d."
	ewarn
	ewarn "PLEASE NOTE: Everything is off by default with access restricted to localhost."
	ewarn
	einfo "Check /etc/conf.d/xinetd for the startup options."
	echo ""
}
