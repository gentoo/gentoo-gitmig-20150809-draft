# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/cfs/cfs-1.4.1.14.ebuild,v 1.1 2004/09/17 21:48:30 mkennedy Exp $

inherit eutils

MY_PV=${PV:0:5}
DEB_PV=${PV:6:2}

# This is a port of the Debian port of CFS which includes several
# useful patches.  Many thanks to the Debian developers.

DESCRIPTION="Cryptographic Filesystem"
HOMEPAGE="http://packages.debian.org/unstable/utils/cfs
	http://www.crypto.com/software/"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cfs/cfs_${MY_PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cfs/cfs_${MY_PV}-${DEB_PV}.diff.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="net-fs/nfs-utils"

S=${WORKDIR}/${PN}-${MY_PV}.orig

# Originally from the common-lisp-common.eclass:

do-debian-credits() {
	docinto debian
	for i in copyright README.Debian changelog; do
		# be silent, since all files are not always present
		dodoc ${S}/debian/${i} &>/dev/null || true
	done
	docinto .
}

cfsd-running() {
	test -n "$(mount |grep '\(/var/cfs\|/var/lib/cfs/\.cfsfs\)')"
}

pkg_setup() {
	if cfsd-running; then
		eerror "It seems that the null directory or CFS root is currently in use."
		eerror "You must shutdown CFS before merging this port or at least unmount"
		eerror "the CFS root before using this port."
		die
	fi
}

src_unpack() {
	unpack ${A}
	epatch cfs_${MY_PV}-${DEB_PV}.diff
}

src_compile() {
	make cfs COPT="${CFLAGS} -DPROTOTYPES -g" || die
}

src_install() {
	make install_cfs BINDIR=${D}/usr/bin ETCDIR=${D}/usr/sbin || die
	insinto /etc/conf.d
	newins ${FILESDIR}/cfsd.conf cfsd
#	exeinto /var/lib/cfs
#	doexe debian/cfs_*mount.sh
	keepdir /var/run/cfs
	keepdir /var/cfs
	keepdir /var/lib/cfs/.cfsfs
	chmod 0 ${D}/var/lib/cfs/.cfsfs
	doman *.[18]
	exeinto /etc/init.d/
	newexe ${FILESDIR}/cfsd.init cfsd
	do-debian-credits
	dodoc LEVELS README* VERSION
	dodoc ${FILESDIR}/README.Gentoo
}

pkg_postinst() {
	rm -f /var/lib/cfs/.cfsfs/.keep
	einfo "Please read /usr/share/docs/cfs-${PF}/README.Gentoo for"
	einfo "information on how to get started with CFS on Gentoo."
}
