# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/autofs/autofs-5.0.3-r5.ebuild,v 1.3 2008/05/12 21:45:33 solar Exp $

inherit eutils multilib autotools

IUSE="ldap sasl"
DESCRIPTION="Kernel based automounter"
HOMEPAGE="http://www.linux-consulting.com/Amd_AutoFS/autofs.html"
SRC_URI_BASE="mirror://kernel/linux/daemons/${PN}/v5"
SRC_URI="${SRC_URI_BASE}/${P}.tar.bz2
		${SRC_URI_BASE}/${P}-ldap-page-control-configure-fix.patch
		${SRC_URI_BASE}/${P}-xfn-not-supported.patch
		${SRC_URI_BASE}/${P}-basedn-with-spaces-fix-3.patch
		${SRC_URI_BASE}/${P}-nfs4-tcp-only.patch
		${SRC_URI_BASE}/${P}-correct-ldap-lib.patch
		${SRC_URI_BASE}/${P}-dont-fail-on-empty-master-fix-2.patch
		${SRC_URI_BASE}/${P}-expire-works-too-hard.patch
		${SRC_URI_BASE}/${P}-unlink-mount-return-fix.patch
		${SRC_URI_BASE}/${P}-update-linux-auto_fs4-h.patch
		${SRC_URI_BASE}/${P}-expire-works-too-hard-update.patch
		${SRC_URI_BASE}/${P}-expire-works-too-hard-update-2.patch
		${SRC_URI_BASE}/${P}-handle-zero-length-nis-key.patch
		${SRC_URI_BASE}/${PN}-5.0.2-init-cb-on-load.patch
		${SRC_URI_BASE}/${P}-map-type-in-map-name.patch
		${SRC_URI_BASE}/${P}-mount-thread-create-cond-handling.patch"
DEPEND="virtual/libc
		ldap? ( >=net-nds/openldap-2.0 )
		sasl? ( virtual/krb5 )"
			# currently, sasl code assumes the presence of kerberosV
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

src_unpack() {
	unpack ${P}.tar.bz2
	PATCH_LIST="
		${P}-ldap-page-control-configure-fix.patch
		${P}-xfn-not-supported.patch
		${P}-basedn-with-spaces-fix-3.patch
		${P}-nfs4-tcp-only.patch
		${P}-correct-ldap-lib.patch
		${P}-dont-fail-on-empty-master-fix-2.patch
		${P}-expire-works-too-hard.patch
		${P}-unlink-mount-return-fix.patch
		${P}-update-linux-auto_fs4-h.patch
		${P}-expire-works-too-hard-update.patch
		${P}-expire-works-too-hard-update-2.patch
		${P}-handle-zero-length-nis-key.patch
		${PN}-5.0.2-init-cb-on-load.patch
		${P}-map-type-in-map-name.patch
		${P}-mount-thread-create-cond-handling.patch"
	for i in ${PATCH_LIST}; do
		cp ${DISTDIR}/${i} ${T}
	done
	patch "${T}"/${P}-map-type-in-map-name.patch \
		< "${FILESDIR}"/${P}-map-patch-fix.patch || die "failed to patch"
	for i in ${PATCH_LIST}; do
		EPATCH_OPTS="-p1 -d ${S}" epatch ${T}/${i}
		rm -f ${T}/${i}
	done

	# fixes bug #210762
	epatch "${FILESDIR}"/${P}-heimdal.patch

	cd "${S}"

	# # use CC and CFLAGS from environment (bug #154797)
	# write these values in Makefile.conf
	(echo "# Use the compiler and cflags determined by configure";
	echo "CC := @CC@"; echo "CFLAGS := @CFLAGS@") >> Makefile.conf.in
	# make sure Makefile.conf is parsed after Makefile.rules
	sed -ni '/include Makefile.conf/{x; n; G}; p' Makefile
	sed -i 's/^\(CC\|CXX\).*//' Makefile.rules
	sed -i 's/^CFLAGS=-fPIE.*//' configure.in

	# do not include <nfs/nfs.h>, rather <linux/nfs.h>,
	# as the former is a lame header for the latter (bug #157968)
	sed -i 's@nfs/nfs.h@linux/nfs.h@' include/rpc_subs.h

	eautoreconf || die "Autoconf failed"
}

src_compile() {
	CFLAGS="${CFLAGS}" \
	econf \
		$(use_with ldap openldap) \
		$(use_with sasl) \
		--enable-ignore-busy \
		|| die "configure failed"

	emake DONTSTRIP=1 || die "make failed"
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
