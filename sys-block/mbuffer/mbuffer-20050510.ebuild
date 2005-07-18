# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/mbuffer/mbuffer-20050510.ebuild,v 1.2 2005/07/18 05:16:23 vapier Exp $

inherit eutils

DESCRIPTION="M(easuring)buffer is a replacement for buffer with additional functionality"
HOMEPAGE="http://www.rcs.ei.tum.de/~maierkom/privat/software/mbuffer/"
SRC_URI="http://www.rcs.ei.tum.de/~maierkom/privat/software/mbuffer/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug mhash"

RDEPEND="mhash? ( app-crypt/mhash )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-20050321-configure.patch
	epatch "${FILESDIR}"/${PN}-20050510-md5-type.patch #99347
}

src_compile() {
	econf \
		$(use_enable mhash md5) \
		$(use_enable debug) \
		|| die "econf failed"
	emake || die "compile problem"
}

src_install() {
	dodir /usr/bin
	make install exec_prefix="${D}"/usr || die "install failed"
	dodoc AUTHORS INSTALL NEWS README ChangeLog
}
