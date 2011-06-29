# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/stride/stride-20011129-r1.ebuild,v 1.4 2011/06/29 05:42:13 jlec Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Protein secondary structure assignment from atomic coordinates"
HOMEPAGE="http://webclu.bio.wzw.tum.de/stride/"
SRC_URI="ftp://ftp.ebi.ac.uk/pub/software/unix/${PN}/src/${PN}.tar.gz
	mirror://gentoo/${PN}-20060723-update.patch.bz2"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

S="${WORKDIR}"

src_prepare() {
	# this patch updates the source to the most recent
	# version which was kindly provided by the author
	epatch \
		"${DISTDIR}/${PN}-20060723-update.patch.bz2" \
		"${FILESDIR}"/${PN}-LDFLAGS.patch

	# fix makefile
	sed -e "/^CC/s|gcc -g|$(tc-getCC) ${CFLAGS}|" -i Makefile || \
		die "Failed to fix Makefile"
}

src_install() {
	dobin ${PN}
}
