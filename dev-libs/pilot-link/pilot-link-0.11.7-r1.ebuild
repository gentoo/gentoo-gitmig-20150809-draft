# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pilot-link/pilot-link-0.11.7-r1.ebuild,v 1.2 2003/05/16 01:00:36 pylon Exp $

inherit perl-module

DESCRIPTION="suite of tools for moving data between a Palm device and a desktop"
SRC_URI="http://pilot-link.org/source/${P}.tar.bz2"
HOMEPAGE="http://www.pilot-link.org/"

SLOT="0"
LICENSE="GPL-2 | LGPL-2"
KEYWORDS="~x86 ppc ~sparc"
IUSE="perl java tcltk python png readline"

DEPEND="virtual/glibc
	sys-libs/ncurses
	perl? ( dev-lang/perl )
	java? ( virtual/jre )
	tcltk? ( dev-lang/tcl dev-tcltk/itcl dev-lang/tk )
	python? ( dev-lang/python )
	png? ( media-libs/libpng )
	readline? ( sys-libs/readline )"

src_compile() {
	local myconf="--with-gnu-ld --includedir=/usr/include/libpisock"

	use java \
		&& myconf="${myconf} --with-java=yes" \
		|| myconf="${myconf} --with-java=no"

	use perl \
		&& myconf="${myconf} --with-perl=yes" \
		|| myconf="${myconf} --with-perl=no"

	use python \
		&& myconf="${myconf} --with-python=yes" \
		|| myconf="${myconf} --with-python=no"

	use tcltk \
		&& myconf="${myconf} --with-tcl=yes --with-itcl=yes --with-tk=yes" \
		|| myconf="${myconf} --with-tcl=no --with-itcl=no --with-tk=no"

	use png && myconf="${myconf} --with-libpng=/usr"

	use readline \
		&& myconf="${myconf} --with-readline=yes" \
		|| myconf="${myconf} --with-readline=no"

	econf ${myconf} || die
	# java fails w/emake
	make || die

	if [ `use perl` ] ; then
		cd ${S}/bindings/Perl
		perl-module_src_prep
		perl-module_src_compile
	fi
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc ChangeLog README doc/README* doc/TODO NEWS AUTHORS

	if [ `use perl` ] ; then
		cd ${S}/bindings/Perl
		perl-module_src_install
	fi
}
