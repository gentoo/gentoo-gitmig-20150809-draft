# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xalbumlist/xalbumlist-2.2.ebuild,v 1.2 2004/03/26 21:03:38 eradicator Exp $

DESCRIPTION="A control program for XMMS"
HOMEPAGE="http://xalbumlist.sourceforge.net/"
SRC_URI="mirror://sourceforge/xalbumlist/xalbumlist_${PV}-1.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND=">=media-sound/xmms-1.2.7
	>=dev-perl/gtk2-perl-0.90
	>=dev-perl/gtk2-gladexml-0.90
	>=dev-perl/Xmms-Perl-0.12
	>=dev-perl/MP3-Info-1.02
	>=gnome-base/libglade-2.0.1"

src_install() {
	make DESTDIR=${D}/usr install || die

	dodoc ChangeLog README TODO
}

