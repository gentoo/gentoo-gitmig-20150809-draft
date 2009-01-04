# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/autofs/autofs-5.0.4.ebuild,v 1.1 2009/01/04 12:31:28 stefaan Exp $

inherit eutils multilib autotools

IUSE="ldap sasl"
DESCRIPTION="Kernel based automounter"
HOMEPAGE="http://www.linux-consulting.com/Amd_AutoFS/autofs.html"
SRC_URI_BASE="mirror://kernel/linux/daemons/${PN}/v5"
# This list is taken directly from http://kernel.org/pub/linux/daemons/autofs/v5/patch_order-5.0.3
# Please do not modify the order
PATCH_LIST="
	${P}-fix-dumb-libxml2-check.patch
	${P}-expire-specific-submount-only.patch
	${P}-fix-negative-cache-non-existent-key.patch
	${P}-fix-ldap-detection.patch"
SRC_URI="${SRC_URI_BASE}/${P}.tar.bz2"
for i in ${PATCH_LIST} ; do
	SRC_URI="${SRC_URI} ${SRC_URI_BASE}/${i}"
done ;
DEPEND="virtual/libc
		ldap? ( >=net-nds/openldap-2.0 )
		sasl? ( virtual/krb5 )"
			# currently, sasl code assumes the presence of kerberosV
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

src_unpack() {
	unpack ${P}.tar.bz2
	for i in ${PATCH_LIST}; do
		EPATCH_OPTS="-p1 -d ${S}" epatch "${DISTDIR}"/${i}
	done

	cd "${S}"

	# fixes bug #210762
	epatch "${FILESDIR}"/${PN}-5.0.3-heimdal.patch

	# fixes bugs #253412 and #247969
	epatch "${FILESDIR}"/${P}-user-ldflags-and-as-needed.patch

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
