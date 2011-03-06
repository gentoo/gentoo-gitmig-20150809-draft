# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/mrbayes/mrbayes-3.1.2-r1.ebuild,v 1.1 2011/03/06 16:53:59 jlec Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="Bayesian Inference of Phylogeny"
HOMEPAGE="http://mrbayes.csit.fsu.edu/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug mpi readline"
KEYWORDS="~amd64 ~x86 ~x86-linux ~ppc-macos ~sparc-solaris"

DEPEND="
	mpi? ( virtual/mpi )
	readline? ( sys-libs/readline )"
RDEPEND="${DEPEND}"

src_prepare() {
	use readline && epatch "${FILESDIR}"/mb_readline_312.patch
}

src_compile() {
	local myconf
	use mpi && myconf="MPI=yes"
	use readline || myconf="${myconf} USEREADLINE=no"
	use debug && myconf="${myconf} DEBUG=yes"
	emake \
		OPTFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		CC=$(tc-getCC) \
		${myconf}
}

src_install() {
	dobin mb
	insinto /usr/share/${PN}
	doins *.nex
}
