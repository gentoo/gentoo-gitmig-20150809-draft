# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-menueditor/xfce4-menueditor-1.05.ebuild,v 1.2 2004/04/05 01:48:53 bcowan Exp $

IUSE=""
S=${WORKDIR}/${PN}

DESCRIPTION="Xfce4 desktop menu editor"
HOMEPAGE="http://users.skynet.be/p0llux/"
SRC_URI="http://users.skynet.be/p0llux/files/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ia64 x86 ~ppc ~alpha ~sparc ~amd64"

RDEPEND=">=x11-libs/gtk+-2.0.6
	dev-libs/libxml2
	xfce-base/xfce4-base"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf \
	    --disable-cvs
	emake
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc BUGS TODO ChangeLog
}
