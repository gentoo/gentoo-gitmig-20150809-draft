# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xcompmgr/xcompmgr-1.1.ebuild,v 1.6 2006/11/05 16:46:35 joshuabaergen Exp $

WANT_AUTOCONF=2.5
WANT_AUTOMAKE=1.7

inherit eutils autotools

IUSE=""

DESCRIPTION="X Compositing manager"
HOMEPAGE="http://freedesktop.org/Software/xapps"
SRC_URI="http://freedesktop.org/~xapps/release/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="amd64 ppc x86"

RDEPEND=">=x11-base/xorg-x11-6.8.0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	./autogen.sh || die
	econf || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog
}
