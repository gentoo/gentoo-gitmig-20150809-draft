# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/txt2tags/txt2tags-1.6.ebuild,v 1.2 2004/01/14 12:45:15 obz Exp $

DESCRIPTION="Txt2tags is a tool for generating marked up documents (HTML, SGML, ...) from a plain text file with markup."
SRC_URI="http://txt2tags.sourceforge.net/src/${P}.tgz"
HOMEPAGE="http://txt2tags.sourceforge.net/"
LICENSE="GPL-2"

IUSE="tcltk"
KEYWORDS="x86 ~sparc"
SLOT="0"

DEPEND="tcltk? ( dev-lang/tk )"

DOCS="COPYING ChangeLog.txt README.txt RULES TODO"

pkg_setup() {

	# need to test if the tcltk support in python is working
	if [ `use tcltk` ]; then
		if ! python -c "import _tkinter" 2>&1 > /dev/null ; then
			echo ""
			eerror "You have requested tcltk, but your build of Python"
			eerror "doesnt support import _tkinter. You may need to"
			eerror "remerge dev-lang/python, or build ${P}"
			eerror "with USE=\"-tcltk\""
			die
		fi
	fi

}

src_install () {

	dobin txt2tags
	dodoc ${DOCS}
	# samples go into "samples" doc directory
	docinto samples
	dodoc samples/*
	# extras go into "extras" doc directory
	docinto extras
	dodoc extras/*
	# the userguide as well
	docinto userguide
	dodoc userguide/*

}
