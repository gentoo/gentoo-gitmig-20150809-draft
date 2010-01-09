# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/root-docs/root-docs-5.26.00.ebuild,v 1.1 2010/01/09 17:48:02 bicatali Exp $

inherit versionator

S=${WORKDIR}/htmldoc
DESCRIPTION="An Object-Oriented Data Analysis Framework"
VER=$(str=( $(get_version_components) ); echo "${str[0]}${str[1]}")
SRC_URI="ftp://root.cern.ch/root/html${VER}.tar.gz"
HOMEPAGE="http://root.cern.ch/"

SLOT="0"
LICENSE="as-is"
IUSE=""
KEYWORDS="~x86 ~ppc ~amd64"

src_install() {
	docpath="/usr/share/doc/${PF}/"
	mkdir -p "$D"/${docpath}
	cp -r * "$D"/${docpath}
}
