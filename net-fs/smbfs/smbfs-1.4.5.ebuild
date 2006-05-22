# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/smbfs/smbfs-1.4.5.ebuild,v 1.1 2006/05/22 22:39:25 flameeyes Exp $

inherit bsdmk eutils

DESCRIPTION="Mount SMB/CIFS share on FreeBSD and derived"
HOMEPAGE="https://sourceforge.net/projects/smbfs"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86-fbsd"
IUSE=""

DEPEND="dev-libs/libiconv"

pkg_setup() {
	mymakeopts="${mymakeopts} COMPLETEBUIlD="
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-freebsd5.patch
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	mkmake configure || die "mkmake configure failed"
	mkmake || die "mkmake failed"
}

src_install() {
	mkinstall DESTDIR="${D}/usr/" PREFIX="" || die "mkinstall failed"
}

