# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/david/david-0.99.2.ebuild,v 1.4 2002/07/23 10:38:07 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The C/C++ Code editor for Gnome"
SRC_URI="http://david.es.gnome.org/downloads/${P}.tar.gz"
HOMEPAGE="http://david.es.gnome.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=dev-libs/libxml-1.8.16
	=x11-libs/gtk+-1.2*
	>=gnome-base/gnome-libs-1.4.1.5
	>=media-libs/audiofile-0.2.3
	>=media-sound/esound-0.2.23
	=dev-libs/glib-1.2*"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf=""

	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf} || die "./configure failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "installation failed"
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
