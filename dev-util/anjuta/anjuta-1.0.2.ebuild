# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/anjuta/anjuta-1.0.2.ebuild,v 1.10 2004/07/14 22:35:29 agriffis Exp $

IUSE="nls"
DESCRIPTION="A versatile Integrated Development Environment (IDE) for C and C++."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://anjuta.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc"

RDEPEND="=gnome-base/libglade-0*
	>=gnome-base/ORBit-0.5.0
	>=gnome-base/gnome-print-0.35
	=gnome-base/gnome-vfs-1.0*
	>=gnome-base/bonobo-1.0
	>=gnome-base/gnome-libs-1.4.1.2-r1
	>=dev-libs/libxml-1.4.0
	dev-libs/libpcre
	dev-util/ctags
	dev-util/indent
	>=sys-devel/bison-1.0
	>=app-text/scrollkeeper-0.1.4
	media-libs/gdk-pixbuf
	media-gfx/gnome-iconedit
	media-libs/audiofile
	media-sound/esound
	sys-devel/gdb
	sys-apps/grep
	=x11-libs/gtk+-1.2*"

DEPEND="dev-util/pkgconfig
	${RDEPEND}"

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
