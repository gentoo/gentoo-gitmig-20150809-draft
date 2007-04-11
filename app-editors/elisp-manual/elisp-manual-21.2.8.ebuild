# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/elisp-manual/elisp-manual-21.2.8.ebuild,v 1.14 2007/04/11 10:27:54 opfer Exp $

inherit versionator

MY_PV=$(replace_version_separator 1 '-' )
DESCRIPTION="The GNU Emacs Lisp Reference Manual"
HOMEPAGE="http://ftp.gnu.org/gnu/Manuals/elisp-manual-${MY_PV}/elisp.html"
SRC_URI="mirror://gnu/Manuals/elisp-manual-${MY_PV}/info/elisp-info.tar.gz"

LICENSE="FDL-1.2"
SLOT="0"
IUSE=""
KEYWORDS="x86 ppc sparc s390 amd64"

DEPEND=""
RDEPEND=""

S=${WORKDIR}

src_install() {
	doinfo elisp.info*
}
