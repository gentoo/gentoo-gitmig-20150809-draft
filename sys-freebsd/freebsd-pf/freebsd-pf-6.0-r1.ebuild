# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-pf/freebsd-pf-6.0-r1.ebuild,v 1.2 2006/04/20 07:04:29 flameeyes Exp $

inherit bsdmk freebsd

DESCRIPTION="FreeBSD's base system libraries"
SLOT="0"
KEYWORDS="~x86-fbsd"

IUSE=""

# Crypto is needed to have an internal OpenSSL header
SRC_URI="mirror://gentoo/${USBIN}.tar.bz2
		mirror://gentoo/${SBIN}.tar.bz2
		mirror://gentoo/${CONTRIB}.tar.bz2
		mirror://gentoo/${LIBEXEC}.tar.bz2
		mirror://gentoo/${ETC}.tar.bz2"

RDEPEND="net-libs/libpcap"
DEPEND="${RDEPEND}
	=sys-freebsd/freebsd-mk-defs-${RV}*
	=sys-freebsd/freebsd-sources-${RV}*"

S="${WORKDIR}"

SUBDIRS="libexec/ftp-proxy usr.sbin/authpf sbin/pfctl sbin/pflogd"

PATCHES="${FILESDIR}/${PN}-${RV}-pcap.patch"

src_unpack() {
	freebsd_src_unpack

	ln -s "/usr/src/sys-${RV}" "${WORKDIR}/sys"
}

src_compile() {
	for dir in ${SUBDIRS}; do
		einfo "Starting make in ${dir}"
		cd "${S}/${dir}"
		mkmake || die "Make ${dir} failed"
	done
}

src_install() {
	for dir in ${SUBDIRS}; do
		einfo "Starting install in ${dir}"
		cd "${S}/${dir}"
		mkinstall || die "Install ${dir} failed"
	done

	cd ${WORKDIR}/etc
	insinto /etc
	doins pf.conf pf.os

	newinitd "${FILESDIR}/pf.initd" pf
	newconfd "${FILESDIR}/pf.confd" pf
}
