# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/atftp/atftp-0.7.ebuild,v 1.10 2005/02/07 21:11:03 vapier Exp $

inherit eutils

DESCRIPTION="Advanced TFTP implementation client/server"
HOMEPAGE="ftp://ftp.mamalinux.com/pub/atftp/"
SRC_URI="ftp://ftp.mamalinux.com/pub/atftp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 arm ~ppc ~sparc ~x86"
IUSE="tcpd"

DEPEND="tcpd? ( sys-apps/tcp-wrappers )
	!virtual/tftp"
PROVIDE="virtual/tftp"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc.patch
}

src_compile() {
	econf $(use_enable tcpd libwrap) || die "./configure failed"
	emake CFLAGS="${CFLAGS} -D_REENTRANT" || die
}

src_install() {
	make install DESTDIR="${D}" || die "Installation failed"
	newinitd ${FILESDIR}/atftp.init atftp
	newconfd ${FILESDIR}/atftp.confd atftp
}
