# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/xfsamba/xfsamba-0.47.ebuild,v 1.5 2002/10/04 06:15:47 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A GUI SMB network navigator"
SRC_URI="http://xfsamba.sourceforge.net/archive/${P}.tar.gz"
HOMEPAGE="http://xfsamba.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"
DEPEND="=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	nls? ( sys-devel/gettext )"
RDEPEND=">=net-fs/samba-2.2.4"

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"

	./configure ${myconf} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--disable-gtktest \
		--disable-glibtest || die "./configure failed"
	
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die "install failed"
}

