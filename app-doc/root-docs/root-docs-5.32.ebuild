# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/root-docs/root-docs-5.32.ebuild,v 1.1 2012/03/13 17:15:19 bicatali Exp $

EAPI=3
inherit versionator

DESCRIPTION="An Object-Oriented Data Analysis Framework"
MYP=html$(replace_version_separator 1 '')

SRC_URI="ftp://root.cern.ch/root/${MYP}.tar.gz"
HOMEPAGE="http://root.cern.ch/"

SLOT="0"
LICENSE="as-is"
IUSE=""
KEYWORDS="~amd64 ~x86"

S=${WORKDIR}/htmldoc

src_install() {
	insinto /usr/share/doc/${PF}/html
	# use mv, there is too much to copy
	mv ${MYP}/* "${ED}"/usr/share/doc/${PF}/
}
