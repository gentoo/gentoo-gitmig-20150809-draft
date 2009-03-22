# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/gmap/gmap-2007.09.28.ebuild,v 1.3 2009/03/22 16:32:22 maekke Exp $

inherit versionator

MY_PV=$(replace_all_version_separators '-')

DESCRIPTION="A Genomic Mapping and Alignment Program for mRNA and EST Sequences"
HOMEPAGE="http://www.gene.com/share/gmap/"
SRC_URI="http://www.gene.com/share/gmap/src/gmap-${MY_PV}.tar.gz"

LICENSE="gmap"
SLOT="0"
IUSE=""
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/gmap-${MY_PV}"

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog README
}
