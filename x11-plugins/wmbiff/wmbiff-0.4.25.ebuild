# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbiff/wmbiff-0.4.25.ebuild,v 1.1 2004/07/25 20:50:51 s4t4n Exp $

DESCRIPTION="WMBiff is a dock applet for WindowMaker which can monitor up to 5 mailboxes."
SRC_URI="mirror://sourceforge/wmbiff/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/wmbiff/"

DEPEND="virtual/x11
		crypt? ( >=net-libs/gnutls-1.0.4
			>=dev-libs/libgcrypt-1.1.94 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
IUSE="crypt"

#This has been fixed upstream
#src_unpack() {
#	unpack ${A}
#	cd ${S}
#	if use crypt; then
#		if has_version ">dev-libs/libgcrypt-1.1.12"; then
#			epatch ${FILESDIR}/${P}-crypto-api-fix.patch
#		fi
#	fi
#}

src_compile() {
	local myconf
	if ! use crypt; then
			myconf="--disable-crypto"
	fi
	econf ${myconf} || die
	emake || die
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog  FAQ NEWS  README  README.licq  TODO  wmbiff/sample.wmbiffrc
}
