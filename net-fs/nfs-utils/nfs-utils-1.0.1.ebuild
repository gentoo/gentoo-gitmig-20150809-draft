# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/nfs-utils/nfs-utils-1.0.1.ebuild,v 1.1 2002/10/13 09:36:07 bcowan Exp $

IUSE="tcpd"

DESCRIPTION="NFS client and server daemons"
SRC_URI="mirror://sourceforge/nfs/${P}.tar.gz"
HOMEPAGE="http://nfs.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="tcpd? ( sys-apps/tcp-wrappers )"
RDEPEND="${DEPEND} >=net-nds/portmap-5b-r6"

src_compile() {
	./configure \
		--prefix=/ \
		--mandir=/usr/share/man \
		--with-statedir=/var/lib/nfs \
		--enable-rquotad --enable-nfsv3 || die "Configure failed"

	if ! use tcpd; then
		sed -e "s:\(-lwrap\|-DHAVE_TCP_WRAPPER\)::" < config.mk > config.mk.new
		mv --force config.mk.new config.mk
	fi

	# parallel make still fails 
	make || die "Failed to compile"
}

src_install() {
	make install install_prefix=${D} MANDIR=${D}/usr/share/man || die "Failed to install"

	insinto /etc ; doins ${FILESDIR}/exports

	dodoc ChangeLog COPYING README
	docinto linux-nfs ; dodoc linux-nfs/*

	exeinto /etc/init.d ; newexe ${FILESDIR}/nfs nfs ; newexe ${FILESDIR}/nfsmount nfsmount
	insinto /etc/conf.d ; newins ${FILESDIR}/nfs.confd nfs
}

pkg_postinst() {

	einfo "NFS V2 and V3 servers now default to \"sync\" IO if ${P} version (or later) is installed."
	einfo "More info at ${HOMEPAGE} (see questions 5, 12, 13, and 14)."
	echo
	ewarn "PLEASE note: Since the latest NFS utils has changed the server default to \"sync\" IO,"
	ewarn "then if no behavior is specified in the export list, thus assuming the default behavior,"
	ewarn "a warning will be generated at export time."
	echo
	# Running depscan since we introduced /etc/init.d/{portmap,nfs}
	/etc/init.d/depscan.sh
}
