# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-menueditor/xfce4-menueditor-1.0.ebuild,v 1.1 2004/02/02 21:16:56 bcowan Exp $

IUSE=""
S=${WORKDIR}/${PN}

DESCRIPTION="Xfce4 menu editor"
HOMEPAGE="http://users.skynet.be/p0llux/"
SRC_URI="http://users.skynet.be/p0llux/files/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ia64 ~x86 ~ppc ~alpha ~sparc ~amd64"

DEPEND=">=x11-libs/gtk+-2.0.6
	dev-util/pkgconfig
	dev-libs/libxml2
	xfce-base/xfce4-base"

src_compile() {
	econf \
	    --disable-cvs
	emake
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc BUGS TODO ChangeLog
}
