# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/hfsutils/hfsutils-3.2.6-r4.ebuild,v 1.8 2006/03/23 02:06:32 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="HFS FS Access utils"
HOMEPAGE="http://www.mars.org/home/rob/proj/hfs/"
SRC_URI="ftp://ftp.mars.org/pub/hfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"
IUSE="tcltk"

DEPEND="tcltk? ( dev-lang/tcl dev-lang/tk )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/hfsutils-3.2.6-errno.patch
	epatch "${FILESDIR}"/hfsutils-3.2.6-softlinks.patch
	epatch "${FILESDIR}"/largerthan2gb.patch
}

src_compile() {
	tc-export CC CPP LD RANLIB
	econf \
		$(use_with tcltk tcl) \
		$(use_with tcltk tk) \
		|| die
	emake PREFIX=/usr MANDIR=/usr/share/man || die
	emake -C hfsck PREFIX=/usr MANDIR=/usr/share/man || die
}

src_install() {
	dodir /usr/bin /usr/lib /usr/share/man/man1
	make \
		prefix="${D}"/usr \
		MANDEST="${D}"/usr/share/man \
		infodir="${D}"/usr/share/info \
		install || die
	dobin hfsck/hfsck || die
	dodoc BLURB CHANGES README TODO doc/*.txt
}
