# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtksourceview/gtksourceview-0.2.1.ebuild,v 1.1 2003/06/07 04:28:17 bcowan Exp $

IUSE="nls"

S=${WORKDIR}/${P}

DESCRIPTION="Text widget that improves GtkTextView by adding syntax highlighting"
HOMEPAGE="http://www.gnome.org"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/sources/gtksourceview/0.2/${P}.tar.bz2"


LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
SLOT="0"

DEPEND=">=x11-libs/gtk+-2.2*
	>=dev-libs/libxml2-2.5*
	>=gnome-base/gnome-vfs-2.2*"

src_compile() {
	local myconf=""
	
	use nls || myconf="${myconf} --disable-nls"
	
	econf ${myconf}
	emake
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog HACKING INSTALL MAINTAINERS NEWS README TODO
}
