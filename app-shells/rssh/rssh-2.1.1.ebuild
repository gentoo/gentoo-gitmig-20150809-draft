# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/rssh/rssh-2.1.1.ebuild,v 1.1 2003/07/27 08:43:05 vapier Exp $

DESCRIPTION="restricted shell for SSHd"
HOMEPAGE="http://rssh.sourceforge.net/"
SRC_URI="mirror://sourceforge/rssh/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="static"

RDEPEND="net-misc/openssh"

src_compile() {
	econf \
		--with-scp=/usr/bin/scp \
		--with-sftp-server=/usr/lib/misc/sftp-server \
		`use_enable static` \
		|| die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog CHROOT INSTALL README TODO
}
