# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gomd-cvs/gomd-cvs-0.2_beta1.ebuild,v 1.2 2004/02/13 22:41:01 tantive Exp $

DESCRIPTION="gomd is a daemon which executes commands and gets information from the nodes of an openMosix cluster. It has to run on every node in order to collect data, and it waits for commands to execute. gomd stands for general openMosix daemon."
HOMEPAGE="http://nongnu.org/gomd"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -ppc -alpha -sparc"

DEPEND="dev-cpp/commoncpp2
	gnome-base/libgtop"

inherit cvs

ECVS_USER="anoncvs"
ECVS_SERVER="savannah.nongnu.org:/cvsroot/gomd"
ECVS_AUTH="ext"
ECVS_SSH_HOST_KEY="savannah.nongnu.org,199.232.41.4 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEAzFQovi+67xa+wymRz9u3plx0ntQnELBoNU4SCl3RkwSFZkrZsRTC0fTpOKatQNs1r/BLFoVt21oVFwIXVevGQwB+Lf0Z+5w9qwVAQNu/YUAFHBPTqBze4wYK/gSWqQOLoj7rOhZk0xtAS6USqcfKdzMdRWgeuZ550P6gSzEHfv0="
#CVS_RSH="ssh"
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
