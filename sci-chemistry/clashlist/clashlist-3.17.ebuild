# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/clashlist/clashlist-3.17.ebuild,v 1.1 2010/07/19 06:43:59 jlec Exp $

# inherit

DESCRIPTION="Build lists of van der Waals clashes from an input PDB file"
HOMEPAGE="http://kinemage.biochem.duke.edu/software/index.php"
SRC_URI="mirror://gentoo/molprobity-${PV}.tgz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="richardson"
IUSE=""

RDEPEND="
	sci-chemistry/cluster
	sci-chemistry/probe"
DEPEND="${RDEPEND}"

src_install() {
	dobin molprobity3/bin/clashlist || die
}
