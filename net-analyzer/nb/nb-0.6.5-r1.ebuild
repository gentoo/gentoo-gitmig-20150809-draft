# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nb/nb-0.6.5-r1.ebuild,v 1.2 2010/02/11 15:57:34 jer Exp $

inherit eutils autotools

DESCRIPTION="Nodebrain is a tool to monitor and do event correlation."
HOMEPAGE="http://nodebrain.sourceforge.net/"
SRC_URI="mirror://sourceforge/nodebrain/${P}-source.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="!sys-boot/netboot"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-CFLAGS-as-needed.patch"
	eautoreconf
}

src_install() {
	#DIR="${D}/usr" ./install-nb || die "install failed"
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README THANKS sample/*
	dohtml html/*
}
