# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/audit/audit-0.8.1.ebuild,v 1.1 2005/05/19 18:15:39 robbat2 Exp $

DESCRIPTION="Userspace utilities for storing and processing auditing records."
HOMEPAGE="http://people.redhat.com/sgrubb/audit/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-devel/libtool
	virtual/os-headers
	>=sys-devel/automake-1.9
	>=sys-devel/autoconf-2.59"
RDEPEND=""

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S} || die "cd '${S}' failed"
	WANT_AUTOMAKE="1.9" \
		autoreconf -fv --install || die "autoreconf failed"
}

src_compile() {
	econf --sbindir=/sbin --libdir=/lib || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
	dodir /usr/lib
	mv ${D}/lib/*.a ${D}/usr/lib
	# remove RH garbage
	rm -rf ${D}/etc/rc.d ${D}/etc/sysconfig
	# docs
	dodoc AUTHORS ChangeLog README* THANKS TODO sample.rules
	# scripts
	newinitd ${FILESDIR}/auditd.initd-0.7.2-r1 auditd
	newconfd ${FILESDIR}/auditd.confd-0.7.2-r1 auditd
	# audit logs go here
	keepdir /var/log/audit/
	# restrictive perms for security
	chmod 0750 ${D}/sbin/{auditctl,auditd,ausearch,autrace} ${D}/var/log/audit/
	chmod 0640 ${D}/etc/{auditd.conf,audit.rules}
}

pkg_postinst() {
	# upstream wants these to have restrictive perms
	chmod 0750 /sbin/{auditctl,auditd,ausearch,autrace} /var/log/audit/
	chmod 0640 /etc/{auditd.conf,audit.rules}
}
