# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-arch/dump/dump-0.4.28.ebuild,v 1.1 2002/04/27 04:27:42 seemant Exp $

MY_P=${P/4./4b}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Dump/restore ext2fs backup utilities"
SRC_URI="http://download.sourceforge.net/dump/${MY_P}.tar.gz"
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
	dodoc CHANGES COPYRIGHT INSTALL KNOWNBUGS MAINTAINERS README \
		REPORTING-BUGS THANKS TODO
	cp -a examples/dump_on_cd ${D}/usr/share/doc/${PF}
}
