# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/ASFiles/ASFiles-1.0.ebuild,v 1.6 2002/07/22 13:38:41 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="NeXTish filemanager, hacked from OffiX"
SRC_URI="http://www.tigr.net/afterstep/download/ASFiles/ASFiles-1.0.tar.gz"
HOMEPAGE="http://www.tigr.net/afterstep/list.pl"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=x11-wm/afterstep-1.8.8
		>=x11-libs/dnd-1.1"
RDEPEND=$DEPEND

src_unpack() {
	unpack ASFiles-1.0.tar.gz
	cd ${S}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	econf \
		--with-x \
		--with-dnd-inc=/usr/include/OffiX \
		--with-dnd-lib=/usr/lib || die
	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		datadir=${D}/usr/share \
		mandir=${D}/usr/share/man \
		install || die

}

