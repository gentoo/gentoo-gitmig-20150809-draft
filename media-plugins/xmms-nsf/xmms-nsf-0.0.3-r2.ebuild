# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-nsf/xmms-nsf-0.0.3-r2.ebuild,v 1.3 2006/09/03 23:03:36 tsunam Exp $

inherit eutils gnuconfig autotools libtool

IUSE=""

DESCRIPTION="An xmms input-plugin for NSF-files (the nintendo 8-bit soundfiles) that uses source from NEZamp."
HOMEPAGE="http://www.xmms.org/"
SRC_URI="http://optronic.sourceforge.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#-sparc: 0.0.3: Plays, but not completely... misses notes
KEYWORDS="amd64 -ppc -sparc x86"

DEPEND="media-sound/xmms
	=x11-libs/gtk+-1.2*"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-about.patch
	epatch ${FILESDIR}/${P}-PIC.patch
	epatch ${FILESDIR}/${P}-compilefixes.patch

	gnuconfig_update

	export WANT_AUTOMAKE=1.4
	eautomake
	elibtoolize
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}
