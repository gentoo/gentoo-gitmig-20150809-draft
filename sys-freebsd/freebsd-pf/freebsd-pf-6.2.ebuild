# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-pf/freebsd-pf-6.2.ebuild,v 1.2 2007/01/18 21:12:11 drizzt Exp $

inherit bsdmk freebsd

DESCRIPTION="FreeBSD's base system libraries"
SLOT="0"
KEYWORDS="~x86-fbsd"

IUSE=""

# Crypto is needed to have an internal OpenSSL header
SRC_URI="mirror://gentoo/${USBIN}.tar.bz2
		mirror://gentoo/${SBIN}.tar.bz2
		mirror://gentoo/${CONTRIB}.tar.bz2
		mirror://gentoo/${ETC}.tar.bz2"

RDEPEND="net-libs/libpcap"
DEPEND="${RDEPEND}
	sys-freebsd/freebsd-mk-defs
	=sys-freebsd/freebsd-sources-${RV}*"

S="${WORKDIR}"

SUBDIRS="usr.sbin/authpf sbin/pfctl sbin/pflogd"

PATCHES="${FILESDIR}/${PN}-6.0-pcap.patch"

pkg_setup() {
	enewgroup authpf 63
	mymakeopts="${mymakeopts} NO_MANCOMPRESS= NO_INFOCOMPRESS= "
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

	cd "${WORKDIR}"/etc
	insinto /etc
	doins pf.os
	newdoc pf.conf pf.conf.example

	newinitd "${FILESDIR}/pf.initd" pf
	newconfd "${FILESDIR}/pf.confd" pf
}
