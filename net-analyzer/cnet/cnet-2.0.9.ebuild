# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cnet/cnet-2.0.9.ebuild,v 1.1 2004/11/21 11:50:22 eldad Exp $

inherit eutils

DESCRIPTION="Network simulation tool"
SRC_URI="http://www.csse.uwa.edu.au/cnet/${P}.tgz"
HOMEPAGE="http://www.csse.uwa.edu.au/cnet"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

# cnet will NOT work against elfutils (but it will compile!) Bug #67375. (21 Nov 2004 eldad)
DEPEND=">=dev-lang/tk-8.3.4
	dev-libs/libelf"

#RDEPEND=""

# unpacking the source
src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gentoo.patch
	sed -i.orig -e "s/^CFLAGS.*/CFLAGS=${CFLAGS}/" ${S}/src/Makefile.linux
}

src_install() {
	# these directories aren't created during the make install
	# process, so we'll need to make them beforehand, or else
	# we'll have nowhere to put the files
	mkdir -p ${D}/usr/{bin,lib,share}
	mkdir -p ${D}/usr/share/man/man1
	# install with make now
	emake PREFIX=${D}/usr install || die

	#install examples
	DOCDESTTREE=EXAMPLES
	dodir /usr/share/doc/${PF}/${DOCDESTTREE}
	dodoc EXAMPLES/*
}
