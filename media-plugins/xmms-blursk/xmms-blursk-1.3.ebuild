# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-blursk/xmms-blursk-1.3.ebuild,v 1.3 2004/04/14 09:53:55 eradicator Exp $

IUSE=""

MY_P=Blursk-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Yet another psychedelic visualization plug-in for XMMS"
HOMEPAGE="http://www.cs.pdx.edu/~kirkenda/blursk/"
SRC_URI="http://www.cs.pdx.edu/~kirkenda/blursk/${MY_P}.tar.gz"

DEPEND="media-sound/xmms"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

src_install () {
	make DESTDIR=${D} install || die "install failed"

	dodoc AUTHORS COPYING ChangeLog INSTALL README NEWS
}
