# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/doxygen/doxygen-1.3.2.ebuild,v 1.9 2004/01/12 21:08:16 nerdboy Exp $

IUSE="doc qt"

DESCRIPTION="Doxygen is a documentation system for C++, C, Java, IDL (Corba, Microsoft, and KDE-DCOP flavors) and to some extent PHP and C#."
HOMEPAGE="http://www.doxygen.org"
SRC_URI="ftp://ftp.stack.nl/pub/users/dimitri/${P}.src.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc ~alpha hppa"

RDEPEND="media-gfx/graphviz
	doc? ( virtual/tetex
		virtual/ghostscript )
	qt? ( x11-libs/qt )"

DEPEND=">=sys-apps/sed-4
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	# use CFLAGS and CXXFLAGS
	sed -i.orig -e "s:^\(TMAKE_CFLAGS_RELEASE\t*\)= .*$:\1= ${CFLAGS}:" \
		-e "s:^\(TMAKE_CXXFLAGS_RELEASE\t*\)= .*$:\1= ${CXXFLAGS}:" \
		tmake/lib/linux-g++/tmake.conf
	# fix doxygen_manual.tex to work with latex-2.x
	sed -i.orig "s:^\\\setlength\({\\\footrulewidth}\):\\\renewcommand\1:" \
		doc/doxygen_manual.tex
	# fix configure to work w/ install from either fileutils or coreutils
	sed -ie "s/grep fileutils/egrep 'fileutils|coreutils'/" ${S}/configure
}

src_compile() {
	# set ./configure options (prefix, Qt based wizard, static)
	local confopts="--prefix ${D}/usr"
	use qt && confopts="${confopts} --with-doxywizard"
	#use static && confopts="${confopts} --static"

	# ./configure and compile
	./configure ${confopts} || die '"./configure" failed.'
	emake all || die '"emake all" failed.'

	# generate html and pdf documents.
	# errors here are not considered fatal, hence the ewarn message
	# TeX's font caching in /var/cache/fonts causes sandbox warnings,
	# so we allow it.
	if use doc; then
		addwrite /var/cache/fonts
		addwrite /usr/share/texmf/fonts/pk
		addwrite /usr/share/texmf/ls-R
		make pdf || ewarn '"make docs" failed.'
	fi
}

src_install() {
	make install || die '"make install" failed.'

	dodoc INSTALL LANGUAGE.HOWTO LICENSE README VERSION

	# pdf and html manuals
	if use doc; then
		insinto /usr/share/doc/${P}
		doins latex/doxygen_manual.pdf
		dohtml -r html/*
	fi
}
