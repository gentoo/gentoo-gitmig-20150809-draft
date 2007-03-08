# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmms/libmms-0.3.ebuild,v 1.7 2007/03/08 00:34:45 weeve Exp $

DESCRIPTION="Common library for accessing Microsoft Media Server (MMS) media streaming protocol"

HOMEPAGE="http://libmms.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/glib-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e "s:<malloc.h>:<stdlib.h>:g" -i src/uri.c || die "sed failed."
}

src_compile() {
	econf || die
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README* TODO
}
