# Copyright 1999-20022 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-blursk/xmms-blursk-1.2.ebuild,v 1.1 2002/06/19 08:25:57 george Exp $

DESCRIPTION="Yet another psychedelic visualization plug-in for XMMS"

NAME="Blursk"
SRC_URI="http://www.cs.pdx.edu/~kirkenda/blursk/${NAME}-${PV}.tar.gz"
HOMEPAGE="http://www.cs.pdx.edu/~kirkenda/blursk/"
LICENSE="GPL-2"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-sound/xmms-1.2.6-r5"
RDEPEND="${DEPEND}"

SLOT="0"

S=${WORKDIR}/${NAME}-${PV}


src_install () {

	make DESTDIR=${D} install || die "install failed"

	dodoc AUTHORS COPYING ChangeLog INSTALL README NEWS

}
