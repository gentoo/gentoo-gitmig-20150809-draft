# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/autofs/autofs-4.1.3-r1.ebuild,v 1.4 2005/03/23 01:09:02 agriffis Exp $

inherit eutils

IUSE="ldap"

DESCRIPTION="Kernel based automounter"
HOMEPAGE="http://www.linux-consulting.com/Amd_AutoFS/autofs.html"
SRC_URI_BASE="mirror://kernel/linux/daemons/${PN}/v4"
SRC_URI="${SRC_URI_BASE}/${P}.tar.bz2
		${SRC_URI_BASE}/${P}-strict.patch
		${SRC_URI_BASE}/${P}-mtab_lock.patch
		${SRC_URI_BASE}/${P}-bad_chdir.patch
		${SRC_URI_BASE}/${P}-non_block_ping.patch
		${SRC_URI_BASE}/${P}-signal-race-fix.patch
		${SRC_URI_BASE}/${P}-sock-leak-fix.patch
		${SRC_URI_BASE}/${P}-replicated_server_select.patch"
DEPEND="virtual/libc
		ldap? ( >=net-nds/openldap-2.0 )"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

src_unpack() {
	unpack ${P}.tar.bz2
	PATCH_LIST="${P}-strict.patch ${P}-mtab_lock.patch ${P}-bad_chdir.patch ${P}-non_block_ping.patch ${P}-signal-race-fix.patch ${P}-sock-leak-fix.patch ${P}-replicated_server_select.patch"
	for i in ${PATCH_LIST}; do
		EPATCH_OPTS="-p1 -d ${S}" epatch ${DISTDIR}/${i}
	done

	cd ${S}
	autoconf || die "Autoconf failed"

	cd ${S}/daemon
	sed -i 's/LIBS \= \-ldl/LIBS \= \-ldl \-lnsl \$\{LIBLDAP\}/' Makefile || die "LIBLDAP change failed"
}

src_compile() {
	local myconf
	use ldap || myconf="--without-openldap"

	econf ${myconf} || die
	sed -i -e '/^\(CFLAGS\|CXXFLAGS\|LDFLAGS\)[[:space:]]*=/d' Makefile.rules || die "Failed to remove (C|CXX|LD)FLAGS"
	emake || die "make failed"
}

src_install() {
	into /usr
	dosbin daemon/automount
	exeinto /usr/lib/autofs
	doexe modules/*.so

	dodoc COPYING COPYRIGHT NEWS README* TODO CHANGELOG CREDITS
	cd ${S}/samples
	docinto samples ; dodoc auto.misc auto.master
	cd ${S}/man
	sed -i 's:\/etc\/:\/etc\/autofs\/:g' *.8 *.5 *.in || die "Failed to update path in manpages"
	doman auto.master.5 autofs.5 autofs.8 automount.8

	dodir /etc/autofs /etc/init.d /etc/conf.d
	insinto /etc/autofs ; doins ${FILESDIR}/auto.master
	insinto /etc/autofs ; doins ${FILESDIR}/auto.misc
	exeinto /etc/autofs ; doexe ${FILESDIR}/auto.net # chmod 755 is important!

	exeinto /etc/init.d ; newexe ${FILESDIR}/autofs.rc9 autofs
	insinto /etc/conf.d ; newins ${FILESDIR}/autofs.confd9 autofs
	if use ldap; then
		cd ${S}/samples
		docinto samples ; dodoc ldap* auto.master.ldap
		insinto /etc/openldap/schema ; doins autofs.schema
		exeinto /usr/lib/autofs ; doexe autofs-ldap-auto-master
	fi
}

pkg_postinst() {
	einfo "Note: If you plan on using autofs for automounting"
	einfo "remote NFS mounts without having the NFS daemon running"
	einfo "please add portmap to your default run-level."
	echo ""
	einfo "Also the normal autofs status has been renamed stats"
	einfo "as there is already a predefined Gentoo status"
}
