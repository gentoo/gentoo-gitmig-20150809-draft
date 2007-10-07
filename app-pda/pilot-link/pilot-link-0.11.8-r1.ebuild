# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/pilot-link/pilot-link-0.11.8-r1.ebuild,v 1.20 2007/10/07 17:15:16 philantrop Exp $

inherit perl-module eutils

DESCRIPTION="suite of tools for moving data between a Palm device and a desktop"
HOMEPAGE="http://www.pilot-link.org/"
SRC_URI="http://pilot-link.org/source/${P}.tar.bz2"

LICENSE="|| ( GPL-2 LGPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc ~x86"
IUSE="perl java tk python png readline"

DEPEND="sys-libs/ncurses
	perl? ( dev-lang/perl )
	java? ( virtual/jre )
	tk? ( dev-lang/tcl dev-tcltk/itcl dev-lang/tk )
	python? ( dev-lang/python )
	png? ( media-libs/libpng )
	readline? ( sys-libs/readline )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-java_fPIC_fix.patch"

	if use java; then
		if use ppc; then
			epatch "${FILESDIR}/${P}-java_install_ppc.patch"
		elif use amd64; then
			epatch "${FILESDIR}/${P}-java_install_amd64.patch"
		else
			epatch "${FILESDIR}/${P}-java_install_all.patch"
		fi
	fi

	epatch "${FILESDIR}"/${P}-m4.patch

	# fixes bug 162209
	epatch "${FILESDIR}/${P}-missing-include.patch"

	# bug #62873
	cd "${S}/libpisock"; epatch "${FILESDIR}/${P}-netsync.patch"
}

src_compile() {
	local myconf="--includedir=/usr/include/libpisock"

	use java \
		&& myconf="${myconf} --with-java=yes" \
		|| myconf="${myconf} --with-java=no"

	use perl \
		&& myconf="${myconf} --with-perl=yes" \
		|| myconf="${myconf} --with-perl=no"

	use python \
		&& myconf="${myconf} --with-python=yes" \
		|| myconf="${myconf} --with-python=no"

	use tk \
		&& myconf="${myconf} --with-tcl=/usr/lib --with-itcl=yes --with-tk=yes" \
		|| myconf="${myconf} --with-tcl=no --with-itcl=no --with-tk=no"

	use png && myconf="${myconf} --with-libpng=/usr"

	use readline \
		&& myconf="${myconf} --with-readline=yes" \
		|| myconf="${myconf} --with-readline=no"

	econf ${myconf} || die
	# java fails w/emake
	make || die

	if use perl ; then
		cd "${S}/bindings/Perl"
		perl-module_src_prep
		perl-module_src_compile
	fi
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc ChangeLog README doc/README* doc/TODO NEWS AUTHORS

	if use perl ; then
		cd "${S}/bindings/Perl"
		perl-module_src_install
	fi
}
