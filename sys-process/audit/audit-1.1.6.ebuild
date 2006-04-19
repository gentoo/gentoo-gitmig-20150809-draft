# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/audit/audit-1.1.6.ebuild,v 1.1 2006/04/19 23:17:16 robbat2 Exp $

inherit eutils autotools

DESCRIPTION="Userspace utilities for storing and processing auditing records."
HOMEPAGE="http://people.redhat.com/sgrubb/audit/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"
IUSE=""

RDEPEND=">=dev-lang/python-2.4"
DEPEND="${RDEPEND}
		dev-lang/swig
		>=sys-kernel/linux-headers-2.6.17_rc1"
# Do not use os-headers as this is linux specific
# linux-headers 2.6.17_rc1 is NOT in the tree yet.

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S} || die "cd '${S}' failed"
	eautoreconf || die "eautoreconf failed"
}

src_compile() {
	econf --sbindir=/sbin --libdir=/lib || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodir /usr/lib
	mv ${D}/lib/*.a ${D}/usr/lib
	rm -rf ${D}/lib/*.la ${D}/usr/lib/*.la
	# remove RedHat garbage
	rm -rf ${D}/etc/rc.d ${D}/etc/sysconfig
	# docs
	dodoc AUTHORS ChangeLog README* THANKS TODO sample.rules contrib/*
	# scripts
	newinitd ${FILESDIR}/auditd.initd-0.7.2-r1 auditd
	newconfd ${FILESDIR}/auditd.confd-0.7.2-r1 auditd
	# audit logs go here
	keepdir /var/log/audit/
	lockdown_perms ${D}
}

pkg_postinst() {
	lockdown_perms /
}

lockdown_perms() {
	# upstream wants these to have restrictive perms
	basedir="$1"
	chmod 0750 ${basedir}/sbin/{auditctl,aureport,audispd,auditd,ausearch,autrace} ${D}/var/log/audit/
	chmod 0640 ${basedir}/etc/{auditd.conf,audit.rules}
}
