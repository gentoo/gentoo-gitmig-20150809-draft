# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/anjuta/anjuta-1.1.1.ebuild,v 1.1 2003/06/07 14:10:01 malverian Exp $

IUSE=""
S=${WORKDIR}/${P}
DESCRIPTION="A versatile Integrated Development Environment (IDE) for C and C++."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://anjuta.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND=">=gnome-base/libglade-2
        >=gnome-base/libgnomeui-2.2
        >=gnome-base/libbonobo-2
        =gnome-base/libgnomeprintui-2.2*
	>=x11-libs/gtk+-2
        >=gnome-base/ORBit2-2
        >=gnome-base/gnome-vfs-2.2
	>=dev-libs/libxml-1.4.0
	dev-util/pkgconfig
	dev-libs/libpcre
	>=app-text/scrollkeeper-0.3.12
	>=sys-devel/bison-1.0"	

RDEPEND="media-gfx/gnome-iconedit
	 media-libs/audiofile
	 media-sound/esound
	 dev-util/ctags
	 sys-devel/gdb
	 sys-apps/grep
	 x11-libs/libzvt
	 >=sys-libs/db-3.2.3
	 dev-util/indent"

src_compile() {

	local myconf
	use nls || myconf="--disable-nls"

	econf ${myconf} --enable-final || die
	emake || die
}

src_install () {

	einstall \
		anjutadocdir=${D}/usr/share/doc/${PF} || die

	dodoc AUTHORS COPYING ChangeLog FUTURE NEWS README THANKS TODO
}
