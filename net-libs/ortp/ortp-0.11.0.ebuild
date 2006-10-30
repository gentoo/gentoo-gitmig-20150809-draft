# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/ortp/ortp-0.11.0.ebuild,v 1.2 2006/10/30 23:55:12 peper Exp $

DESCRIPTION="Open Real-time Transport Protocol (RTP) stack"
HOMEPAGE="http://www.linphone.org/index.php/v2/code_review/ortp/"
SRC_URI="http://download.savannah.nongnu.org/releases/linphone/${PN}/sources/${P}.tar.gz"

IUSE="ipv6"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

DEPEND="=dev-libs/glib-2*
		>=dev-util/pkgconfig-0.9.0"
RDEPEND="=dev-libs/glib-2*"

src_compile() {
	econf --disable-ewarning \
		$(use_enable ipv6) || die 'configure failed'
	emake || die 'make compile failed'
}

src_install() {
	emake DESTDIR=${D} install || die "Make install failed"

	dodoc README ChangeLog AUTHORS TODO NEWS
	dodoc docs/*.txt
}
