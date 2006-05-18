# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gomd-cvs/gomd-cvs-0.2_beta1.ebuild,v 1.6 2006/05/18 16:43:35 halcy0n Exp $

inherit cvs

DESCRIPTION="gomd is a daemon which executes commands and gets information from the nodes of an openMosix cluster. It has to run on every node in order to collect data, and it waits for commands to execute. gomd stands for general openMosix daemon."
HOMEPAGE="http://nongnu.org/gomd"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -ppc -alpha -sparc"
IUSE=""

DEPEND="dev-cpp/commoncpp2
	gnome-base/libgtop"

ECVS_SERVER="cvs.savannah.nongnu.org:/sources/gomd"
ECVS_AUTH="pserver"
ECVS_USER="anonymous"
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
