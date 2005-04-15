# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/p3nfs/p3nfs-5.16.ebuild,v 1.1 2005/04/15 11:56:31 brix Exp $

inherit flag-o-matic

DESCRIPTION="Symbian to Unix and Linux communication program"
HOMEPAGE="http://www.koeniglich.de/p3nfs.html"
SRC_URI="http://www.koeniglich.de/packages/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="net-nds/portmap"

src_compile() {
	append-ldflags -Wl,-z,now
	sed -i "s:\$(LDFLAGS):${LDFLAGS}:" ${S}/nfsd/Makefile.in

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"

	dodoc CHANGES README TODO
}

pkg_postinst() {
	einfo
	einfo "You need to install one of the nfsapp-*.sis clients on your"
	einfo "Symbian device to be able to mount it's filesystems."
	einfo
	einfo "Make sure to have portmap running before you start the"
	einfo "p3nfsd server."
	einfo
}
