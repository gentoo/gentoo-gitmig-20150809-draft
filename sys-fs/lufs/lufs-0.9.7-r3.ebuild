# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lufs/lufs-0.9.7-r3.ebuild,v 1.3 2005/01/23 19:35:08 dholm Exp $

inherit eutils

DESCRIPTION="User-mode filesystem implementation"
HOMEPAGE="http://lufs.sourceforge.net/lufs/"
SRC_URI="mirror://sourceforge/lufs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="debug"
DEPEND="sys-fs/lufis
		|| ( =sys-devel/automake-1.7*
			=sys-devel/automake-1.8.5-r1 )
		=sys-devel/autoconf-2.5*"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-fPIC.patch
	epatch ${FILESDIR}/lufs-automount-port.diff
	epatch ${FILESDIR}/${P}-enable-gnome-2.patch

	filesystems="ftpfs localfs sshfs"
}

src_compile() {
	local WANT_AUTOMAKE="1.7" WANT_AUTOCONF="2.5"
	aclocal
	automake
	autoconf

	libtoolize --copy --force

	einfo "Compiling for ${filesystems}"
	unset ARCH
	econf --with-kheaders=${ROOT}/usr/include \
		 $(use_enable debug) || die

	cd filesystems
	for i in ${filesystems}
	do
		cd ${i}
		emake || die "emake failed"
		cd ..
	done
	cd ..

	cd util; emake auto.sshfs auto.ftpfs ||  die "emake failed"; cd ..
}

src_install() {
	cd filesystems
	for i in ${filesystems}
	do
		cd ${i}
		make DESTDIR=${D} install || die "make install failed"
		cd ..
	done
	cd ..

	cd util; dobin auto.sshfs auto.ftpfs; cd ..

	dodir /etc/autofs
	dosym /usr/bin/auto.sshfs /etc/autofs/auto.sshfs
	dosym /usr/bin/auto.ftpfs /etc/autofs/auto.ftpfs
}

pkg_postinst() {
	ewarn "Lufs Kernel support and lufsd,lufsmnt have been disabled in favour"
	ewarn "of lufis, please use lufis to mount lufs-filesystems, eg:"
	echo "# lufis fs=sshfs,host=dev.gentoo.org,username=genstef /mnt/lufis/ -s"
	ewarn "If something does not work for you with this setup please"
	ewarn "complain to bugs.gentoo.org"
	einfo "Note: There is also the native sshfs-fuse implementation now"
}
