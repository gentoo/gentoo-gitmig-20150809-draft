# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/openmotif-manual/openmotif-manual-2.3.0.ebuild,v 1.1 2010/02/06 15:28:17 ulm Exp $

DESCRIPTION="Manual for Open Motif"
HOMEPAGE="http://www.motifzone.net/"
SRC_URI="http://www.motifzone.net/files/documents/openmotif-${PV}-manual.pdf.tgz"

LICENSE="OPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="!<=x11-libs/openmotif-2.3.2"

S="${WORKDIR}"

src_install() {
	dodoc *.pdf || die
}
