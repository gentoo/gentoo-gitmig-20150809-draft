# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/nfs-utils/nfs-utils-1.0.6.ebuild,v 1.9 2004/01/15 22:18:10 agriffis Exp $

IUSE="tcpd"

DESCRIPTION="NFS client and server daemons"
SRC_URI="mirror://sourceforge/nfs/${P}.tar.gz"
HOMEPAGE="http://nfs.sourceforge.net/"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ia64 x86 ~ppc ~alpha sparc ~arm hppa ~amd64"

DEPEND="tcpd? ( sys-apps/tcp-wrappers )"
RDEPEND="${DEPEND} >=net-nds/portmap-5b-r6 >=sys-apps/util-linux-2.11f"

src_compile() {
	./configure \
		--mandir=/usr/share/man \
		--with-statedir=/var/lib/nfs \
		--disable-rquotad --enable-nfsv3 || die "Configure failed"

	if ! use tcpd; then
		sed -i "s:\(-lwrap\|-DHAVE_TCP_WRAPPER\)::" config.mk
	fi

	# parallel make still fails
	make || die "Failed to compile"
}

src_install() {
	make install install_prefix=${D} MANDIR=${D}/usr/share/man \
		|| die "Failed to install"

	# Don't overwrite existing xtab/etab, install the original
	# versions somewhere safe...  more info in pkg_postinst
	mkdir -p ${D}/usr/lib/nfs
	mv ${D}/var/lib/nfs/* ${D}/usr/lib/nfs
	keepdir /var/lib/nfs

	# Install some client-side binaries in /sbin
	mkdir ${D}/sbin
	mv ${D}/usr/sbin/rpc.{lockd,statd} ${D}/sbin

	dodoc ChangeLog COPYING README
	docinto linux-nfs ; dodoc linux-nfs/*

	insinto /etc ; doins ${FILESDIR}/exports

	exeinto /etc/init.d
	newexe ${FILESDIR}/nfs-2 nfs
	newexe ${FILESDIR}/nfsmount nfsmount

	insinto /etc/conf.d
	newins ${FILESDIR}/nfs.confd nfs
}

pkg_postinst() {
	# Install default xtab and friends if there's none existing.
	# In src_install we put them in /usr/lib/nfs for safe-keeping, but
	# the daemons actually use the files in /var/lib/nfs.  This fixes
	# bug 30486
	local f
	for f in ${ROOT}/usr/lib/nfs/*; do
		[[ -f ${ROOT}/var/lib/nfs/${f##*/} ]] && continue
		einfo "Copying default ${f##*/} from /usr/lib/nfs to /var/lib/nfs"
		cp -a ${f} ${ROOT}/var/lib/nfs/
	done

	echo
	einfo "NFS V2 and V3 servers now default to \"sync\" IO if ${P}"
	einfo "(or later) is installed."
	einfo "More info at ${HOMEPAGE} (see questions 5, 12, 13, and 14)."
	echo
	ewarn "PLEASE note: Since the latest NFS utils has changed the server"
	ewarn "default to \"sync\" IO, then if no behavior is specified in the"
	ewarn "export list, thus assuming the default behavior, a warning will"
	ewarn "be generated at export time."
	echo

	# Running depscan since we introduced /etc/init.d/{portmap,nfs}
	/etc/init.d/depscan.sh
}
