# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/selinux-small/selinux-small-2003011510-r1.ebuild,v 1.1 2003/03/17 05:25:50 method Exp $

inherit flag-o-matic

DESCRIPTION="SELinux policy compiler and example policies"
HOMEPAGE="http://www.nsa.gov/selinux"
SRC_URI="http://www.nsa.gov/selinux/archives/${P}.tgz http://www.coker.com.au/selinux/selinux-small/selinux-small_2003011510-6.diff.gz"
LICENSE="GPL-1"
SLOT="0"
S="${WORKDIR}/${P}-gentoo"

KEYWORDS="~x86 -*"
IUSE="selinux"
DEPEND=">=selinux-sources-2.4.20
	>=yacc-1.9.1"


pkg_setup() {
	use selinux || error "You must have selinux USE var"
}

src_compile() {
	ln -s /usr/src/linux ${WORKDIR}/lsm-2.4

	cd ${WORKDIR}/selinux/
	epatch ${WORKDIR}/selinux-small_2003011510-6.diff

	cd ${WORKDIR}/selinux/libsecure
		make SE_INC=/usr/include/linux/flask
	cd ${WORKDIR}/selinux/utils/newrole
		make
	cd ${WORKDIR}/selinux/utils/run_init
		make
	cd ${WORKDIR}/selinux/utils/spasswd
		make
}

src_install() {
	
	insinto /usr/include
	doins ${WORKDIR}/selinux/libsecure/include/*.h

	dolib.a ${WORKDIR}/selinux/libsecure/src/libsecure.a

	UTILS="avc_enforcing avc_toggle load_policy context_to_sid sid_to_context list_sids chsid lchsid chsidfs get_user_sids"
	dobin  ${WORKDIR}/selinux/libsecure/test/{avc_enforcing,avc_toggle,load_policy,context_to_sid,sid_to_context,list_sids,chsid,lchsid,chsidfs,get_user_sids}
	
	dobin ${WORKDIR}/selinux/utils/spasswd/spasswd
	dobin ${WORKDIR}/selinux/utils/run_init/run_init
	dobin ${WORKDIR}/selinux/utils/newrole/newrole
}
