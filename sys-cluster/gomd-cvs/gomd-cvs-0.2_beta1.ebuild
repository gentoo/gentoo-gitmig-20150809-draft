# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gomd-cvs/gomd-cvs-0.2_beta1.ebuild,v 1.1 2004/02/13 21:58:18 tantive Exp $

DESCRIPTION="gomd is a daemon which executes commands and gets information from the nodes of an openMosix cluster. It has to run on every node in order to collect data, and it waits for commands to execute. gomd stands for general openMosix daemon."
HOMEPAGE="http://nongnu.org/gomd"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -ppc -alpha -sparc"

DEPEND="dev-cpp/commoncpp2
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

src_install() {
	./install.sh --libgtop
}

pkg_postinst() {
	ldconfig /usr/lib
}
