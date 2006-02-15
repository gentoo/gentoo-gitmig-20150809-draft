# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mlt++/mlt++-20051209.ebuild,v 1.3 2006/02/15 00:45:27 flameeyes Exp $

DESCRIPTION="Various bindings for mlt"
HOMEPAGE="http://mlt.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
#IUSE="perl python ruby tcl"

#DEPEND="perl?	( dev-lang/swig
#				  dev-lang/perl )
#		python? ( dev-lang/swig
#				  dev-lang/python )
#		ruby?	( dev-lang/swig
#				  dev-lang/ruby )
#		tcl?	( dev-lang/swig
#				  dev-lang/tcl )
DEPEND=">=media-libs/mlt-${PV}"

src_compile() {
#	languages=""
#	if use perl ; then languages="${languages} perl"
#	if use python ; then languages="${languages} python"
#	if use ruby ; then languages="${languages} ruby"
#	if use tcl ; then languages="${languages} tcl"
	./configure --prefix=/usr
	emake
#	if [[ -n "$languages" ]]
#	then
#		cd swig
#		./configure $languages
#		emake
#	fi
}

src_install() {
	make DESTDIR=${D} install

#	if [[ -n "$languages" ]]
#	then
#		cd swig
#		make DESTDIR=${D} install
#	fi

	dodoc README CUSTOMISING HOWTO
}
