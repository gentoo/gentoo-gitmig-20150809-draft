# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/lwm/lwm-1.1.5.ebuild,v 1.1 2003/08/21 21:35:16 seemant Exp $

IUSE="motif"

S=${WORKDIR}/${P}
DESCRIPTION="The ultimate lightweight window manager"
SRC_URI="ftp://ftp.cs.york.ac.uk/pub/james/${P}.tar.gz"
HOMEPAGE="http://www.jfc.org.uk/software/lwm.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ppc"

DEPEND="motif? ( >=sys-apps/sed-4 )
	x11-base/xfree"

src_compile() {
	if [ ! "`use motif`" ]; then
	  sed -i "s/-DHAVE_MOTIF//" Imakefile
	fi
	xmkmf || die
	emake lwm || die
}

src_install() {

	einstall \
		BINDIR=${D}/usr/bin || die

	dodoc COPYRIGHT ChangeLog TODO
}
