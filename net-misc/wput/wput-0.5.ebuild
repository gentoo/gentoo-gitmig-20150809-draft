# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/wput/wput-0.5.ebuild,v 1.2 2005/01/12 11:56:21 ka0ttic Exp $

inherit eutils

DESCRIPTION="a tiny program that looks like wget and is designed to upload files or whole directories to remote ftp-servers"
HOMEPAGE="http://itooktheredpill.dyndns.org/wput/"
SRC_URI="http://itooktheredpill.dyndns.org/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~amd64"
IUSE="debug"

DEPEND="virtual/libc"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	local myconf
	use debug && myconf="--enable-memdbg=yes" || myconf="--enable-g-switch=no"
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog INSTALL TODO
}
