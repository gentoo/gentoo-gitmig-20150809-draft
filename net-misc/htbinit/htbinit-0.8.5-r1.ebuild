# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/htbinit/htbinit-0.8.5-r1.ebuild,v 1.4 2010/10/28 10:08:38 ssuominen Exp $

inherit eutils linux-mod

DESCRIPTION="Sets up Hierachical Token Bucket based traffic control (QoS) with iproute2"
HOMEPAGE="http://www.sourceforge.net/projects/htbinit"
SRC_URI="mirror://sourceforge/htbinit/htb.init-v${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~ppc ~sparc x86"
IUSE="ipv6 esfq"

DEPEND="sys-apps/iproute2"

S=${WORKDIR}

pkg_setup() {
	linux-mod_pkg_setup

	ebegin "Checking for SCH_HTB support"
		linux_chkconfig_present NET_SCH_HTB
		eend $?
		if [[ $? -ne 0 ]] ; then
			eerror "This version needs sch_htb support!"
	        die "sch_htb support not detected!"
		fi
	ebegin "Checking for SCH_SFQ support"
	linux_chkconfig_present NET_SCH_SFQ
	eend $?
	if [[ $? -ne 0 ]] ; then
		eerror "This version needs sch_sfq support!"
	        die "sch_sfqsupport not detected!"
	fi
	ebegin "Checking for CLS_FW support"
		linux_chkconfig_present NET_CLS_FW
		eend $?
		if [[ $? -ne 0 ]] ; then
			eerror "This version needs cls_fw support!"
	        die "cls_fw support not detected!"
		fi
	ebegin "Checking for CLS_U32 support"
		linux_chkconfig_present NET_CLS_U32
		eend $?
		if [[ $? -ne 0 ]] ; then
			eerror "This version needs sch_u32 support!"
	        die "sch_u32 support not detected!"
		fi
	ebegin "Checking for CLS_ROUTE support"
		linux_chkconfig_present NET_CLS_ROUTE
		eend $?
		if [[ $? -ne 0 ]] ; then
			eerror "This version needs cls_route support!"
	        die "cls_route support not detected!"
		fi

	if use esfq; then
		ebegin "Checking for NET_SCH_ESFQ support"
		linux_chkconfig_present NET_SCH_ESFQ
		eend $?

		if [[ $? -ne 0 ]] ; then
			eerror "This version needs sch_esfq support!"
			eerror "See http://fatooh.org/esfq-2.6/"
			die "sch_esfq support not detected!"
		fi
	fi
}

src_unpack() {
	cp "${DISTDIR}"/htb.init-v${PV} "${S}"/htb.init
}

src_compile() {
	sed -i 's|/etc/sysconfig/htb|/etc/htb|g' "${S}"/htb.init
	epatch "${FILESDIR}"/htb.init-v0.8.5_tos.patch
	use ipv6 && epatch "${FILESDIR}"/htb_0.8.5_ipv6.diff
	use esfq && epatch "${FILESDIR}"/htb_0.8.5_esfq.diff
	epatch "${FILESDIR}"/prio_rule.patch
	epatch "${FILESDIR}"/timecheck_fix.patch
	epatch "${FILESDIR}"/htb.init_find_fix.patch
}

src_install() {
	dosbin htb.init

	newinitd "${FILESDIR}"/htbinit.rc htbinit

	keepdir /etc/htb
}

pkg_postinst() {
	einfo 'Run "rc-update add htbinit default" to run htb.init at startup.'
	einfo 'Please, read carefully the htb.init documentation.'
	einfo 'new directory to store configuration /etc/htb'
}
