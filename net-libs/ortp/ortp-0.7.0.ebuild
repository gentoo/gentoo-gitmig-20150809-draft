# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/ortp/ortp-0.7.0.ebuild,v 1.1 2005/03/21 01:00:11 stkn Exp $

IUSE=""

inherit eutils

DESCRIPTION="Open Real-time Transport Protocol (RTP) stack"
HOMEPAGE="http://www.linphone.org/ortp/"
SRC_URI="http://www.linphone.org/ortp/sources/${P}.tar.gz"

S=${WORKDIR}/${P}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

DEPEND=">=dev-libs/glib-2.0.0"

src_compile() {
	econf || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	emake DESTDIR=${D} install || die "Make install failed"

	dodoc README ChangeLog AUTHORS COPYING TODO NEWS INSTALL
	dodoc docs/*
}
