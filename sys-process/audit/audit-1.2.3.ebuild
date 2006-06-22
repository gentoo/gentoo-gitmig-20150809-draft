# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/audit/audit-1.2.3.ebuild,v 1.1 2006/06/22 07:41:46 robbat2 Exp $

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
		>=sys-kernel/linux-headers-2.6.17_p3"
# Do not use os-headers as this is linux specific
# linux-headers 2.6.17_p3 is NOT in the tree yet.
# It is basically linux-headers-2.6.17 + patch-2.6.17-git3 - 2.6.16-appCompat.patch

src_unpack() {
	unpack ${A} || die "unpack failed"
	epatch ${FILESDIR}/${P}-syscall-partial.patch
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
	gen_usr_ldscript libaudit.so libauparse.so
	# remove RedHat garbage
	rm -rf ${D}/etc/rc.d ${D}/etc/sysconfig
	# docs
	dodoc AUTHORS ChangeLog README* THANKS TODO sample.rules contrib/*
	# scripts
	newinitd ${FILESDIR}/auditd-init.d-1.2.3 auditd
	newconfd ${FILESDIR}/auditd-conf.d-1.2.3 auditd
	# Gentoo rules
	insinto /etc/audit/
	doins ${FILESDIR}/audit.rules*
	# audit logs go here
	keepdir /var/log/audit/
	# Security
	lockdown_perms ${D}
}

pkg_postinst() {
	lockdown_perms /
}

lockdown_perms() {
	# upstream wants these to have restrictive perms
	basedir="$1"
	chmod 0750 ${basedir}/sbin/au{ditctl,report,dispd,ditd,search,trace} 2>/dev/null
	chmod 0750 ${basedir}/var/log/audit/ 2>/dev/null
	chmod 0640 ${basedir}/etc/{audit/,}{auditd.conf,audit.rules*} 2>/dev/null
}
