# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/ncpfs/ncpfs-2.2.3.ebuild,v 1.8 2004/07/22 22:08:24 tgall Exp $

inherit eutils

IUSE="nls pam"

DESCRIPTION="Provides Access to Netware services using the NCP protocol (Kernel support must be activated!)"
SRC_URI="ftp://platan.vc.cvut.cz/pub/linux/${PN}/${P}.tar.gz"
HOMEPAGE="ftp://platan.vc.cvut.cz/pub/linux/ncpfs/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ppc64"

DEPEND="nls? ( sys-devel/gettext )
		pam? ( sys-libs/pam )"

src_compile() {

	local myconf

	use nls || myconf="${myconf} --disable-nls"

	myconf="${myconf} `use_enable pam`"

	econf ${myconf} || die "econf failed"
	emake || die
}

src_install () {
	# directory ${D}/lib/security needs to be created or the install fails
	dodir /lib/security
	dodir /usr/sbin
	dodir /sbin
	make DESTDIR=${D} install || die

	dodoc FAQ README
}
