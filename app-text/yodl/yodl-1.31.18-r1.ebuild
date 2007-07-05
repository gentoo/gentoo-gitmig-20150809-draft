# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/yodl/yodl-1.31.18-r1.ebuild,v 1.1 2007/07/05 11:40:06 drac Exp $

inherit eutils

HOMEPAGE="http://www.xs4all.nl/~jantien/yodl"
SRC_URI="ftp://ftp.lilypond.org/pub/${PN}/development/${P}.tar.gz"
DESCRIPTION="Yet oneOther Document Language"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~amd64"
IUSE=""

DEPEND="sys-devel/bison
	sys-devel/flex
	sys-apps/diffutils
	sys-apps/groff
	dev-lang/python
	sys-apps/texinfo"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-python-2.5.patch
	epatch "${FILESDIR}"/bison-configure.patch
	epatch "${FILESDIR}"/${P}-debian.patch
}

src_compile() {
	# Avoid a makefile bug if this var is already defined in the environment.
	unset NAME

	# The auto-dependencies break if ccache is used (for the first compile).
	export CCACHE_DISABLE=yes
	econf --datadir=/usr/share/${PN}
	emake || die "emake failed."

	cd Documentation
	emake info || die "emake info failed."
	ed out/yodl.info <<-EOM >/dev/null 2>&1
	3a
	INFO-DIR-SECTION Miscellaneous
	START-INFO-DIR-ENTRY
	* yodl: (yodl).         High level document preparation system.
	END-INFO-DIR-ENTRY

	.
	wq
	EOM
}

src_install() {
	unset NAME

	einstall datadir="${D}"/usr/share/${PN} || die "einstall failed."

	doinfo Documentation/out/*.info*
	dodoc ANNOUNCE-1.22 ChangeLog-1.22 CHANGES TODO VERSION \
		{ANNOUNCE,AUTHORS,README,PATCHES}.txt
}
