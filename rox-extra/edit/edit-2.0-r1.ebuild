# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/edit/edit-2.0-r1.ebuild,v 1.5 2008/08/28 19:19:53 lack Exp $

ROX_LIB_VER=1.9.14
inherit rox

APPNAME=Edit
APPCATEGORY="Utility;TextEditor"

DESCRIPTION="Edit is a simple text editor for ROX Desktop"
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="mirror://sourceforge/rox/${P}.tgz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

# do some cleanup. Edit 2.0 has CVS dirs included
src_unpack() {
	unpack ${A}
	cd "${S}/${APPNAME}"
	find . -name 'CVS' | xargs rm -fr
	rm -f .cvsignore
	rm -fr tests
}
