# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-status-plugin/xmms-status-plugin-1.0.ebuild,v 1.1 2003/04/21 06:31:24 vladimir Exp $

IUSE="nls"

DESCRIPTION="Provides a docklet for the GNOME Status applet and the KDE panel."
SRC_URI="http://www.hellion.org.uk/source/${P}.tar.gz"
HOMEPAGE="http://www.hellion.org.uk/xmms-status-plugin/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"

DEPEND="media-sound/xmms
	=x11-libs/gtk+-1.2*"

RDEPEND="nls? ( sys-devel/gettext )"

S=${WORKDIR}/${P//_/}

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
