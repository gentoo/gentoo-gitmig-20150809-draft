# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-fs/nfs-utils/nfs-utils-0.3.3-r1.ebuild,v 1.7 2002/08/14 16:54:00 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="kernel NFS client and server daemons"
SRC_URI="http://download.sourceforge.net/nfs/${P}.tar.gz"
HOMEPAGE="http://nfs.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="tcpd? ( sys-apps/tcp-wrappers )"
RDEPEND=">=net-nds/portmap-5b-r6"

src_compile() {
	./configure \
		--prefix=/ \
		--mandir=/usr/share/man \
		--with-statedir=/var/lib/nfs \
		--enable-nfsv3 || die
	if ! use tcpd; then
		cp config.mk config.mk.orig
		sed -e "s:-lwrap::" -e "s:-DHAVE_TCP_WRAPPER::" \
			config.mk.orig > config.mk
	fi

	# nitro: parallel make fails sometimes
	make || die
}

src_install() {
	# MANDIR doesn't pick up install_prefix
	make install install_prefix=$D MANDIR=$D/usr/share/man
	insinto /etc
	doins $FILESDIR/exports
	dodoc ChangeLog COPYING README
	docinto linux-nfs
	dodoc linux-nfs/*
	# using newexe/newins instead of doexe/doins allows us to specify
	# a new filename on the command-line.
	exeinto /etc/init.d
	newexe ${FILESDIR}/nfs nfs
	newexe ${FILESDIR}/nfsmount nfsmount
	insinto /etc/conf.d
	newins ${FILESDIR}/nfs.confd nfs
	# Don't create runlevels symlinks here.  NFS is not something that
	# should be enabled by default.  Administrators can use rc-update
	# to do it themselves.
}
