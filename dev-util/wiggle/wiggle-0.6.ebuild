# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/wiggle/wiggle-0.6.ebuild,v 1.2 2003/06/14 11:26:46 seemant Exp $

IUSE=""

S=${WORKDIR}/${P}

PATCHDATE=20030611
PATCHBALL=${P}-patches-${PATCHDATE}

DESCRIPTION="Wiggle is a program for applying patches that patch cannot apply because of conflicting changes"
HOMEPAGE="http://cgi.cse.unsw.edu.au/~neilb/source/wiggle/"
SRC_URI="http://cgi.cse.unsw.edu.au/~neilb/source/wiggle/${P}.tar.gz
	mirror://gentoo/${PATCHBALL}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"


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


PATCHLIST="001NoQuietTime 002SpecFile 003Recommit"

src_unpack() {
	unpack ${A}

	cd ${S}
	for i in ${PATCHLIST}; do
		epatch ${WORKDIR}/${PATCHBALL}/${i}
	done;
}

src_compile() {
	emake OptDbg="${CFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die

	into /usr
	dobin p
	dodoc ANNOUNCE COPYING INSTALL TODO DOC/diff.ps p.help notes
}
