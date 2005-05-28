# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-nsf/xmms-nsf-0.0.3.ebuild,v 1.14 2005/05/28 23:34:47 luckyduck Exp $

inherit eutils gnuconfig libtool

IUSE=""

DESCRIPTION="An xmms input-plugin for NSF-files (the nintendo 8-bit soundfiles) that uses source from NEZamp."
HOMEPAGE="http://www.xmms.org/"
SRC_URI="http://optronic.sourceforge.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#-sparc: 0.0.3: Plays, but not completely... misses notes
KEYWORDS="x86 -sparc amd64 -ppc"

DEPEND="media-sound/xmms
	=x11-libs/gtk+-1.2*"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc3.patch
	epatch ${FILESDIR}/${P}-PIC.patch

	gnuconfig_update

	export WANT_AUTOMAKE=1.4
	automake || die
	elibtoolize
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
