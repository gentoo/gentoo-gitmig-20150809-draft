# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/elisp-manual/elisp-manual-21.2.8.ebuild,v 1.1 2002/08/23 06:15:10 mkennedy Exp $

MY_PV=21-2.8

DESCRIPTION="The GNU Emacs Lisp Reference Manual"
HOMEPAGE="http://www.gnu.org/manual/elisp-manual-${MY_PV}/elisp.html"
SRC_URI="http://www.gnu.org/manual/elisp-manual-${MY_PV}/info/elisp-info.tar.gz"
LICENSE="FDL-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"

RDEPEND=""
DEPEND="${RDEPEND}"

S=${WORKDIR}/

src_install () {
	doinfo elisp.info*
}
