# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/diff/diff-2.1.2.ebuild,v 1.2 2006/04/16 11:58:25 svyatogor Exp $

inherit eutils rox

MY_PN="Diff"
PATCH_FN="diff-2.1.2_unified-fix.patch"
DESCRIPTION="This is a helper program for ROX-Filer. It displays a coloured context diff between two files"
HOMEPAGE="http://www.kerofin.demon.co.uk/rox/diff.html"
SRC_URI="http://www.kerofin.demon.co.uk/rox/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86"

ROX_CLIB=2.1.0
SET_PERM=true

APPNAME=${MY_PN}
S=${WORKDIR}

# patch to make unified diffs work. Thanks to Stephen Watson, author
src_unpack() {
	unpack ${A}
	cd ${S}/${APPNAME}/src
	epatch ${FILESDIR}/${PATCH_FN}
}
