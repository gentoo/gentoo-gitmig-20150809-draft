# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gomd-cvs/gomd-cvs-0.0_alpha.ebuild,v 1.3 2003/09/10 04:36:17 msterret Exp $

DESCRIPTION="general openMosix daemon"
HOMEPAGE="https://savannah.nongnu.org/forum/forum.php?forum_id=2219"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -ppc -alpha -sparc"

DEPEND="dev-libs/commoncpp2
	gnome-base/libgtop"

inherit cvs

ECVS_USER="anoncvs"
ECVS_SERVER="subversions.gnu.org:/cvsroot/gomd"
ECVS_MODULE="gomd"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
S=${WORKDIR}/${ECVS_MODULE}

src_compile() {
	./compile.sh --with-libgtop
}
