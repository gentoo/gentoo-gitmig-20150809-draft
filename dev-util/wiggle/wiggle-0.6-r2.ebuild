# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/wiggle/wiggle-0.6-r2.ebuild,v 1.3 2005/12/29 17:47:21 dang Exp $

inherit eutils

PATCHDATE=20051211
PATCHBALL=${P}-patches-${PATCHDATE}
DESCRIPTION="program for applying patches that patch cannot apply because of conflicting changes"
HOMEPAGE="http://cgi.cse.unsw.edu.au/~neilb/source/wiggle/"
SRC_URI="http://cgi.cse.unsw.edu.au/~neilb/source/wiggle/${P}.tar.gz
	mirror://gentoo/${PATCHBALL}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

# The 'p' tool does support bitkeeper, but I'm against just dumping it in here
# due to it's size.  I've explictly listed every other dependancy here due to
# the nature of the shell program 'p'
RDEPEND="dev-util/diffstat
	dev-util/patchutils
	sys-apps/diffutils
	sys-apps/findutils
	sys-apps/gawk
	sys-apps/grep
	sys-apps/less
	sys-apps/sed
	sys-apps/coreutils
	sys-devel/patch"
DEPEND="${RDEPEND}
	sys-apps/groff
	sys-process/time"

PATCHLIST="001NoQuietTime 002SpecFile 003Recommit 004ExtractFix 005Pchanges
007Stuff"
# excluded: 006NoDebug 008NewMerge2

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

	dobin p
	dodoc ANNOUNCE INSTALL TODO DOC/diff.ps p.help notes
}
