# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-blursk/xmms-blursk-1.2.ebuild,v 1.6 2004/04/20 17:49:00 eradicator Exp $

IUSE=""


MY_P="Blursk-${PV}"
S=${WORKDIR}/${MY_P}
SRC_URI="http://www.cs.pdx.edu/~kirkenda/blursk/${MY_P}.tar.gz"
HOMEPAGE="http://www.cs.pdx.edu/~kirkenda/blursk/"
DESCRIPTION="Yet another psychedelic visualization plug-in for XMMS"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-sound/xmms-1.2.6-r5"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"


src_install () {
	make DESTDIR=${D} install || die "install failed"

	dodoc AUTHORS COPYING ChangeLog INSTALL README NEWS
}
