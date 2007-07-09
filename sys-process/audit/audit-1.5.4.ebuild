# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/audit/audit-1.5.4.ebuild,v 1.2 2007/07/09 05:05:48 vapier Exp $

inherit autotools multilib toolchain-funcs

DESCRIPTION="Userspace utilities for storing and processing auditing records"
HOMEPAGE="http://people.redhat.com/sgrubb/audit/"
SRC_URI="http://people.redhat.com/sgrubb/audit/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.4"
DEPEND="${RDEPEND}
	dev-lang/swig
	>=sys-kernel/linux-headers-2.6.20-r2"
# Do not use os-headers as this is linux specific

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	# stupid package does not include generated autotools
	eautoreconf
}

src_compile() {
	econf --sbindir=/sbin || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README* THANKS TODO sample.rules contrib/*

	newinitd "${FILESDIR}"/auditd-init.d-1.2.3 auditd
	newconfd "${FILESDIR}"/auditd-conf.d-1.2.3 auditd

	# things like shadow use this so we need to be in /
	dodir /$(get_libdir)
	mv "${D}"/usr/$(get_libdir)/lib*.so* "${D}"/$(get_libdir)/ || die
	gen_usr_ldscript libaudit.so libauparse.so

	# remove RedHat garbage
	rm -r "${D}"/etc/{rc.d,sysconfig} || die

	# Gentoo rules
	insinto /etc/audit/
	doins "${FILESDIR}"/audit.rules*

	# audit logs go here
	keepdir /var/log/audit/

	# Security
	lockdown_perms "${D}"
}

pkg_postinst() {
	lockdown_perms "${ROOT}"
}

lockdown_perms() {
	# upstream wants these to have restrictive perms
	basedir="$1"
	chmod 0750 ${basedir}/sbin/au{ditctl,report,dispd,ditd,search,trace} 2>/dev/null
	chmod 0750 ${basedir}/var/log/audit/ 2>/dev/null
	chmod 0640 ${basedir}/etc/{audit/,}{auditd.conf,audit.rules*} 2>/dev/null
}
