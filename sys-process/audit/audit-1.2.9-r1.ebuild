# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/audit/audit-1.2.9-r1.ebuild,v 1.2 2007/07/14 23:02:48 mr_bones_ Exp $

inherit eutils autotools toolchain-funcs

DESCRIPTION="Userspace utilities for storing and processing auditing records."
HOMEPAGE="http://people.redhat.com/sgrubb/audit/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.4"
DEPEND="${RDEPEND}
		dev-lang/swig
		>=sys-kernel/linux-headers-2.6.17-r1"
# Do not use os-headers as this is linux specific

HEADER_KV="2.6.18-rc4"
src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S} || die "cd '${S}' failed"
	for i in audit.h elf-em.h; do
		cp -f ${FILESDIR}/${i}-${HEADER_KV} ${S}/lib/${i}
	done
	sed -i -e 's,<linux/elf-em.h>,"elf-em.h",g' ${S}/lib/audit.h
	sed -i -e 's,<linux/audit.h>,"audit.h",g' ${S}/lib/libaudit.h
	cp -f ${S}/lib/{audit,elf-em}.h ${S}/src/mt/
	eautoreconf || die "eautoreconf failed"
}

src_compile() {
	econf --sbindir=/sbin --libdir=/$(get_libdir) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodir /usr/lib
	mv ${D}/$(get_libdir)/*.a ${D}/usr/$(get_libdir)
	mv ${D}/$(get_libdir)/*.la ${D}/usr/$(get_libdir)
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
