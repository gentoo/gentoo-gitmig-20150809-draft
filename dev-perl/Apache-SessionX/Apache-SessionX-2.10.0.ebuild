# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-SessionX/Apache-SessionX-2.10.0.ebuild,v 1.2 2011/09/03 21:04:34 tove Exp $

EAPI=4

MODULE_AUTHOR=GRICHTER
MODULE_VERSION=2.01
inherit perl-module

DESCRIPTION="An extented persistence framework for session data"

SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

RDEPEND="dev-perl/Apache-Session"
DEPEND="${RDEPEND}"

src_compile() {
	echo "n" | perl-module_src_compile
}
