# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/wiggle/wiggle-0.6-r3.ebuild,v 1.5 2008/05/15 23:51:12 drac Exp $

inherit eutils fixheadtails toolchain-funcs

PATCHDATE=20060513
PATCHBALL=${P}-patches-${PATCHDATE}
DESCRIPTION="program for applying patches that patch cannot apply because of conflicting changes"
HOMEPAGE="http://cgi.cse.unsw.edu.au/~neilb/source/wiggle/"
SRC_URI="http://cgi.cse.unsw.edu.au/~neilb/source/wiggle/${P}.tar.gz
	mirror://gentoo/${PATCHBALL}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
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
007Stuff 010BestBugFix"
# excluded: 006NoDebug 008NewMerge2 009Stuff

src_unpack() {
	unpack ${A}
	cd "${S}"
	for i in ${PATCHLIST}; do
		epatch "${WORKDIR}"/${PATCHBALL}/${i}
	done;

	# Fix the reference to the help file so `p help' works
	sed -i 's,$0.help,/usr/share/wiggle/p.help,' p

	# Don't add Neil Brown's default sign off lign to every patch
	sed -i '/$CERT/,+4s,^,#,' p

	ht_fix_file p
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} -Wall" \
		wiggle || die "emake wiggle failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."

	dobin p
	dodoc ANNOUNCE INSTALL TODO DOC/diff.ps notes
	insinto /usr/share/wiggle
	doins p.help
}
