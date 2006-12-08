# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/xl2tpd/xl2tpd-1.1.06.ebuild,v 1.1 2006/12/08 21:12:34 mrness Exp $

inherit eutils

DESCRIPTION="A modern version of the Layer 2 Tunneling Protocol (L2TP) daemon"
HOMEPAGE="http://www.xelerance.com/software/xl2tpd/"
SRC_URI="ftp://ftp.xelerance.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="!net-dialup/l2tpd
	net-dialup/ppp"

src_install() {
	dosbin xl2tpd || die 'xl2tpd binary not found'
	doman doc/*.[85]

	dodoc CREDITS README \
		doc/rfc2661.txt doc/*.sample

	dodir /etc/xl2tpd
	head -n 2 doc/l2tp-secrets.sample > "${D}/etc/xl2tpd/l2tp-secrets"
	fperms 0600 /etc/xl2tpd/l2tp-secrets
	newinitd "${FILESDIR}/xl2tpd-init" xl2tpd

	keepdir /var/run/xl2tpd
}

#TODO: remove preinst and postinst functions some time around July 2007
pkg_preinst() {
	if has_version "<=${CATEGORY}/${PN}-1.1.05" && [[ -d "${ROOT}/etc/l2tpd" ]]; then
		ebegin "Migrating /etc/l2tpd to /etc/xl2tpd"
		if [[ -f "${ROOT}/etc/l2tpd/l2tpd.conf" ]] ; then
			sed -i -e 's:/etc/l2tpd/:/etc/xl2tpd/:g' "${ROOT}/etc/l2tpd/l2tpd.conf"
			mv "${ROOT}/etc/l2tpd/l2tpd.conf" "${ROOT}/etc/l2tpd/xl2tpd.conf"
		fi
		mv -f "${ROOT}/etc/l2tpd" "${ROOT}/etc/xl2tpd"
		eend
	fi
}

pkg_postinst() {
	if has_version "<=${CATEGORY}/${PN}-1.1.05"; then
		ewarn "The daemon and service have been renamed from l2tpd to xl2tpd."
		ewarn "Please remove the old init script and configure your system to use"
		ewarn "the new init script:"
		ewarn "   ${HILITE}/etc/init.d/l2tpd stop${NORMAL}"
		ewarn "   ${HILITE}rc-update del l2tpd${NORMAL}"
		ewarn "   ${HILITE}rm /etc/init.d/l2tpd${NORMAL}"
		ewarn "   ${HILITE}rc-update add xl2tpd${NORMAL}"
		ewarn "   ${HILITE}/etc/init.d/xl2tpd start${NORMAL}"
		ebeep
	fi
}
