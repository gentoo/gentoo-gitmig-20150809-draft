# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/wiggle/wiggle-0.6.ebuild,v 1.1 2003/06/11 23:28:02 robbat2 Exp $

DESCRIPTION="Wiggle is a program for applying patches that patch cannot apply because of conflicting changes"
HOMEPAGE="http://cgi.cse.unsw.edu.au/~neilb/source/wiggle/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

PATCHDATE=20030611
PATCHBALL=${P}-patches-${PATCHDATE}
SRC_URI="http://cgi.cse.unsw.edu.au/~neilb/source/wiggle/${P}.tar.gz mirror://gentoo/${PATCHBALL}.tar.bz2"

# The 'p' tool does support bitkeeper, but I'm against just dumping it in here due to it's size.
# I've explictly listed every other dependancy here due to the nature of the shell program 'p'
RDEPEND="dev-util/diffstat
		dev-util/patchutils
		sys-apps/diffutils
		sys-apps/fileutils
		sys-apps/findutils
		sys-apps/gawk
		sys-apps/grep
		sys-apps/less
		sys-apps/sed
		sys-apps/sh-utils
		sys-apps/textutils
		sys-devel/patch"
DEPEND="${RDEPEND}
		sys-apps/groff
		sys-apps/time"

S=${WORKDIR}/${P}

PATCHLIST="001NoQuietTime 002SpecFile 003Recommit"

src_unpack() {
	cd ${WORKDIR}
	unpack ${P}.tar.gz
	unpack ${PATCHBALL}.tar.bz2
	cd ${S}
	for i in ${PATCHLIST}; do
		patch <${WORKDIR}/${PATCHBALL}/${i}
	done;
}

src_compile() {
	emake OptDbg="${CFLAGS}" || die
}

src_install() {
	into /usr
	einstall || die
	dobin p
	dodoc ANNOUNCE COPYING INSTALL TODO DOC/diff.ps p.help notes
	prepalldocs
}
