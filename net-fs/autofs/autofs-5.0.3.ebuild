# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/autofs/autofs-5.0.3.ebuild,v 1.2 2008/02/05 12:32:19 stefaan Exp $

inherit eutils multilib autotools

IUSE="ldap"
DESCRIPTION="Kernel based automounter"
HOMEPAGE="http://www.linux-consulting.com/Amd_AutoFS/autofs.html"
SRC_URI_BASE="mirror://kernel/linux/daemons/${PN}/v5"
SRC_URI="${SRC_URI_BASE}/${P}.tar.bz2
		${SRC_URI_BASE}/${P}-ldap-page-control-configure-fix.patch
		${SRC_URI_BASE}/${P}-xfn-not-supported.patch
		${SRC_URI_BASE}/${P}-basedn-with-spaces-fix-3.patch
		${SRC_URI_BASE}/${P}-nfs4-tcp-only.patch
		${SRC_URI_BASE}/${P}-correct-ldap-lib.patch"
DEPEND="virtual/libc
		ldap? ( >=net-nds/openldap-2.0 )"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

src_unpack() {
	unpack ${P}.tar.bz2
	PATCH_LIST="${P}-ldap-page-control-configure-fix.patch ${P}-xfn-not-supported.patch ${P}-basedn-with-spaces-fix-3.patch ${P}-nfs4-tcp-only.patch ${P}-correct-ldap-lib.patch"
	for i in ${PATCH_LIST}; do
		EPATCH_OPTS="-p1 -d ${S}" epatch ${DISTDIR}/${i}
	done

	cd "${S}"
	eautoconf || die "Autoconf failed"
}

src_compile() {
	econf $(use_with ldap openldap) --enable-ignore-busy || die
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	newinitd "${FILESDIR}"/autofs5.rc1 autofs
}

pkg_postinst() {
	elog "Note: If you plan on using autofs for automounting"
	elog "remote NFS mounts without having the NFS daemon running"
	elog "please add portmap to your default run-level."
}
