# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-arch/dump/dump-0.4.24-r1.ebuild,v 1.1 2002/04/24 16:30:37 mkennedy Exp $

_P=dump-0.4b24
S=${WORKDIR}/${_P}
DESCRIPTION="Dump/restore ext2fs backup utilities"
SRC_URI="http://download.sourceforge.net/dump/${_P}.tar.gz"
HOMEPAGE="http://dump.sourceforge.net"

DEPEND=">=sys-apps/e2fsprogs-1.27
	>=sys-apps/bzip2-1.0.2
	>=sys-libs/zlib-1.1.4
	>=sys-kernel/linux-headers-2.4.10"

RDEPEND="sys-apps/star"

src_compile() {
	local myconf
	./configure --prefix=/usr \
		--with-dumpdatespath=/etc \
		--with-bingroup=root \
		--enable-largefile ${rlconf} \
		--disable-readline \
		--enable-static \
		|| die

	emake || die
}
src_install () {
	into /
	dosbin dump/dump restore/restore
	doman restore/restore.8
	doman dump/dump.8
	dodoc CHANGES COPYRIGHT INSTALL KNOWNBUGS MAINTAINERS README REPORTING-BUGS THANKS TODO
	cp -a examples/dump_on_cd ${D}/usr/share/doc/${PF}
}
