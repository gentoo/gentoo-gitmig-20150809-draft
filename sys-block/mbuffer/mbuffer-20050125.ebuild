# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/mbuffer/mbuffer-20050125.ebuild,v 1.1 2005/03/20 23:40:11 vapier Exp $

inherit eutils

DESCRIPTION="M(easuring)buffer is a replacement for buffer with additional functionality."
HOMEPAGE="http://www.rcs.ei.tum.de/~maierkom/privat/software/mbuffer/"
SRC_URI="http://www.rcs.ei.tum.de/~maierkom/privat/software/mbuffer/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug mhash"

RDEPEND="mhash? ( app-crypt/mhash )"
DEPEND="${RDEPEND}
	~sys-devel/autoconf-2.13"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-configure.patch
	sed -i \
		-e 's:MHASH:HAVE_MHASH:g' \
		configure.in mbuffer.c
	autoconf-2.13 || die "autoconf failed"
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
	einstall exec_prefix="${D}"/usr || die "install failed"
	dodoc AUTHORS INSTALL NEWS README ChangeLog
}
