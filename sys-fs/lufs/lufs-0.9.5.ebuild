# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lufs/lufs-0.9.5.ebuild,v 1.5 2005/01/15 19:50:37 genstef Exp $

DESCRIPTION="User-mode filesystem implementation"
HOMEPAGE="http://lufs.sourceforge.net/lufs/"
SRC_URI="mirror://sourceforge/lufs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="virtual/linux-sources"
RDEPEND=""

src_unpack() {
	unpack ${A}

	# Fix some sandbox failures
	cd ${S}/lufsd
	mv Makefile.in Makefile.in.orig
	sed -e 's/install-exec-hook//' Makefile.in.orig > Makefile.in || die

	cd ${S}/util
	mv Makefile.in Makefile.in.orig
	sed -e 's/install-exec-hook//' Makefile.in.orig > Makefile.in || die

	cd ${S}/kernel/Linux/2.4
	mv Makefile.in Makefile.in.orig
	sed -e 's/install-data-hook//' Makefile.in.orig > Makefile.in || die

	cd ${S}/kernel/Linux/2.5
	mv Makefile.in Makefile.in.orig
	sed -e 's/install-data-hook//' Makefile.in.orig > Makefile.in || die
}

src_install () {
	dodoc AUTHORS COPYING ChangeLog Contributors INSTALL \
		NEWS README THANKS TODO
	dohtml docs/lufs.html
	make DESTDIR=${D} install

	dosym /usr/bin/auto.sshfs /etc/auto.sshfs
	dosym /usr/bin/auto.ftpfs /etc/auto.ftpfs
	dodir /sbin
	dosym /usr/bin/lufsd /sbin/mount.lufs
}

pkg_postinst() {
	/usr/sbin/update-modules
	einfo If you want regular users to be able to mount lufs filesystems,
	einfo you need to run the following command as root:
	einfo \# chmod +s /usr/bin/lufsmnt /usr/bin/lufsumount
}

pkg_postrm() {
	/sbin/modprobe -r lufs
}
