# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-status-plugin/xmms-status-plugin-0.9.ebuild,v 1.3 2002/07/22 00:48:14 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Provides a docklet for the GNOME Status applet and the KDE panel."
SRC_URI="http://www.hellion.org.uk/source/${P}.tar.gz"
HOMEPAGE="http://www.hellion.org.uk/xmms-status-plugin/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="media-sound/xmms
	=x11-libs/gtk+-1.2*"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	use nls \
		&& myconf="--enable-nls" \
		|| myconf="--disable-nls"

	econf ${myconf} || die
	emake || die
}


src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
}
