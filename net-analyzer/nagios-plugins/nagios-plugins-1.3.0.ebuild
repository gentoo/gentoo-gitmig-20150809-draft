# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-plugins/nagios-plugins-1.3.0.ebuild,v 1.1 2003/05/12 18:04:02 alron Exp $
DESCRIPTION="Nagios $PV plugins - Pack of plugins to make Nagios work properly"
HOMEPAGE="http://www.nagios.org/"
SRC_URI="mirror://sourceforge/nagiosplug/nagios-plugins-1.3.0.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc"
IUSE=""
DEPEND=">=bind-tools-9.2.2_rc1
		>=openssl-0.9.6g
		>=perl-5.6.1-r7
		>=fping-2.4_beta2-r1
		>=ntp-4.1.1a
		>=Net-SNMP-4.0.1-r1
		>=net-snmp-5.0.6
		samba? ( >=samba-2.2.5-r1 )
		>=openssh-3.5_p1
		mysql? ( >=mysql-3.23.52-r1 )
		>=autoconf-2.53a
		>=qstat-25
		postgre? ( >=postgresql-7.2 )"
		
S="${WORKDIR}/nagios-plugins-1.3.0"
src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr/nagios \
		--with-nagios-user=nagios \
		--sysconfdir=/etc/nagios \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	make || die
}

src_install() {
	dodoc AUTHORS CODING COPYING ChangeLog FAQ INSTALL LEGALNEWS README REQUIREMENTS ROADMAP Requirements
	make DESTDIR=${D} install || die
}
pkg_preinst() {
	userdel nagios 2> /dev/null
	if ! groupmod nagios; then
		groupadd -g 75 nagios 2> /dev/null || \
		die "Failed to create nagios group"
	fi
	useradd -u 75 -g nagios -s /dev/null -d /var/empty -c "nagios" nagios || \
	die "Failed to create nagios user"
	chown -R nagios:nagios ${D}/usr/nagios/libexec || die "Failed Chown of ${D}/usr/nagios/libexec"
}
