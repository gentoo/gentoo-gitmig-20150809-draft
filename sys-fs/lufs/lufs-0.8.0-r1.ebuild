# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lufs/lufs-0.8.0-r1.ebuild,v 1.5 2005/01/15 19:50:37 genstef Exp $

DESCRIPTION="User-mode filesystem implementation"
HOMEPAGE="http://lufs.sourceforge.net/lufs/"
SRC_URI="mirror://sourceforge/lufs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="virtual/linux-sources"

src_unpack() {
	unpack ${A}

	cd ${S}/lufsd
	mv Makefile.in Makefile.in.orig
	sed -e '497s/install-exec-hook//' Makefile.in.orig > Makefile.in || die

	cd ${S}/util
	mv Makefile.in Makefile.in.orig
	sed -e '429s/install-exec-hook//' Makefile.in.orig > Makefile.in || die

	cd ${S}/kernel2.4
	mv Makefile.in Makefile.in.orig
	sed -e '366s/install-data-hook//' Makefile.in.orig > Makefile.in || die
}

src_install () {
	exeinto /etc/init.d
	newexe ${FILESDIR}/${P}-init lufs

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
	id lufs 2>/dev/null || useradd -g nobody -d /home/lufs -m -s /bin/sh -c "LUFS user" lufs
}

pkg_postrm() {
	userdel lufs
}
