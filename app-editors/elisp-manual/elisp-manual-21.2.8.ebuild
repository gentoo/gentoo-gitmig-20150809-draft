# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/elisp-manual/elisp-manual-21.2.8.ebuild,v 1.7 2004/05/05 12:54:19 kugelfang Exp $

MY_PV=21-2.8
DESCRIPTION="The GNU Emacs Lisp Reference Manual"
HOMEPAGE="http://www.gnu.org/manual/elisp-manual-${MY_PV}/elisp.html"
SRC_URI="http://www.gnu.org/manual/elisp-manual-${MY_PV}/info/elisp-info.tar.gz"

LICENSE="FDL-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc s390 amd64"

DEPEND=""
RDEPEND=""

S=${WORKDIR}

src_install() {
	doinfo elisp.info*
}
