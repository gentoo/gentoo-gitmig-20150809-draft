# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/elisp.eclass,v 1.10 2004/04/10 13:02:38 usata Exp $
#
# Copyright 2002-2003 Matthew Kennedy <mkennedy@gentoo.org>
# Copyright 2003 Jeremy Maitin-Shepard <jbms@attbi.com>
#
# This eclass sets the site-lisp directory for emacs-related packages.

inherit elisp-common
ECLASS=elisp
INHERITED="$INHERITED $ECLASS"

# SRC_URI should be set to wherever the primary app-emacs/ maintainer
# keeps the local elisp mirror, since most app-emacs packages are
# upstream as a single .el file.

# Note: This is no longer necessary.

SRC_URI="http://cvs.gentoo.org/~mkennedy/app-emacs/${P}.el.bz2"
if [ "${SIMPLE_ELISP}" = 't' ]; then
	S="${WORKDIR}/"
#else
#   Use default value
#	S="${WORKDIR}/${P}"
fi

DEPEND="virtual/emacs"
IUSE=""

elisp_src_unpack() {
	unpack ${A}
	if [ "${SIMPLE_ELISP}" = 't' ]
		then
		cd ${S} && mv ${P}.el ${PN}.el
	fi 
}

elisp_src_compile() {
	elisp-compile *.el || die
}

elisp_src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

elisp_pkg_postinst() {
	elisp-site-regen
}

elisp_pkg_postrm() {
	elisp-site-regen
}

EXPORT_FUNCTIONS src_unpack src_compile src_install \
	pkg_postinst pkg_postrm

# Local Variables: ***
# mode: shell-script ***
# tab-width: 4 ***
# indent-tabs-mode: t ***
# End: ***
