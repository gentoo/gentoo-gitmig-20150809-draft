# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author:  Adam Manthei <manthei@sistina.com>
# $Header: /var/cvsroot/gentoo-x86/net-misc/x11-ssh-askpass/x11-ssh-askpass-1.2.2-r1.ebuild,v 1.2 2002/04/27 21:14:31 seemant Exp $


S=${WORKDIR}/${P}
DESCRIPTION="X11-based passphrase dialog for use with OpenSSH"
HOMEPAGE="http://www.ntrnet.net/~jmknoble/software/x11-ssh-askpass/"
SRC_URI="http://www.ntrnet.net/~jmknoble/software/x11-ssh-askpass/${P}.tar.gz"

DEPEND="virtual/glibc virtual/x11"
RDEPEND=">=net-misc/openssh-2.3.0 virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/stupid-imake.diff
}
src_compile() {
	./configure --prefix=/usr --libexecdir=/usr/lib/misc || die
	xmkmf || die
	make includes || die
	make "CDEBUGFLAGS=${CFLAGS}" || die
}


src_install() {
	newman x11-ssh-askpass.man x11-ssh-askpass.1 
	dobin x11-ssh-askpass
	dodir /usr/lib/misc
	dosym /usr/bin/x11-ssh-askpass /usr/lib/misc/ssh-askpass
	dodoc ChangeLog README TODO
}
