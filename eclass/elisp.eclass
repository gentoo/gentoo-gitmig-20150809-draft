# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/elisp.eclass,v 1.8 2003/09/21 01:40:41 mkennedy Exp $
#
# Author Matthew Kennedy <mkennedy@gentoo.org>
#
# This eclass sets the site-lisp directory for emacs-related packages.

inherit elisp-common

ECLASS=elisp
INHERITED="$INHERITED $ECLASS"

source /usr/portage/eclass/elisp-common.eclass

# SRC_URI should be set to wherever the primary app-emacs/ maintainer
# keeps the local elisp mirror, since most app-emacs packages are
# upstream as a single .el file.

# Note: This is no longer necessary.

SRC_URI="http://cvs.gentoo.org/~mkennedy/app-emacs/${P}.el.bz2"
S="${WORKDIR}/"
newdepend "virtual/emacs"
IUSE=""

src_unpack() {
	unpack ${A}
	if [ "${SIMPLE_ELISP}" = 't' ]
	then
		cd ${S} && mv ${P}.el ${PN}.el
	fi 
}

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el || die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}

# Local Variables: ***
# mode: shell-script ***
# tab-width: 4 ***
# indent-tabs-mode: t ***
# End: ***
