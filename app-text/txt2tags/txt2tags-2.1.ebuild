# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/txt2tags/txt2tags-2.1.ebuild,v 1.1 2004/12/03 04:20:52 usata Exp $

inherit elisp-common

IUSE="emacs tcltk"

DESCRIPTION="Txt2tags is a tool for generating marked up documents (HTML, SGML, ...) from a plain text file with markup."
SRC_URI="http://txt2tags.sourceforge.net/src/${P}.tgz"
HOMEPAGE="http://txt2tags.sourceforge.net/"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
DEPEND="virtual/python
	tcltk? ( dev-lang/tk )
	emacs? ( virtual/emacs )"

pkg_setup() {

	# need to test if the tcltk support in python is working
	if use tcltk; then
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

src_compile() {
	if use emacs; then
		elisp-comp extras/txt2tags-mode.el
	fi
}

SITEFILE="50${PN}-gentoo.el"

src_install() {
	dobin t2tconv txt2tags

	dodoc README* doc/RULES TODO ChangeLog* doc/txt2tagsrc
	dohtml doc/userguide/*
	# samples go into "samples" doc directory
	docinto samples
	dodoc samples/abuseme.* samples/sample.*
	docinto samples/css
	dodoc samples/css/*
	docinto samples/img
	dodoc samples/img/*
	# extras go into "extras" doc directory
	docinto extras
	dodoc extras/*

	newman doc/manpage.man txt2tags.1

	# emacs support
	if use emacs; then
		elisp-install ${PN} extras/txt2tags-mode.el
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
	echo
	einfo "NOTE: the format of .t2t files has changed between versions"
	einfo "1.7 -> 2.0.  To convert your .t2t files to the new format,"
	einfo "use the included t2tconv script:"
	einfo
	einfo "    t2tconv file1.t2t file2.t2t ..."
	echo
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
