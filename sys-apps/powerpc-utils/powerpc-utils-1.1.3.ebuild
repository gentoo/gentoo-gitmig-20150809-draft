# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/powerpc-utils/powerpc-utils-1.1.3.ebuild,v 1.18 2004/07/15 02:26:01 agriffis Exp $

DEBRV=3
DESCRIPTION="PowerPC utils; nvsetenv"
SRC_URI="http://http.us.debian.org/debian/pool/main/p/powerpc-utils/powerpc-utils_${PV}.orig.tar.gz
	http://http.us.debian.org/debian/pool/main/p/powerpc-utils/powerpc-utils_${PV}-${DEBRV}.diff.gz"
HOMEPAGE=""
KEYWORDS="ppc -x86 -amd64 -alpha -hppa -mips -sparc"
IUSE=""
DEPEND="virtual/libc"
RDEPEND=""
SLOT="0"
LICENSE="GPL-2"

src_unpack() {
	cd ${WORKDIR}
	unpack powerpc-utils_${PV}.orig.tar.gz
	mv pmac-utils ${P}
	cd ${S}
	cat ${DISTDIR}/powerpc-utils_${PV}-${DEBRV}.diff.gz | gzip -dc | patch -p1 || die
	cd ${WORKDIR}
	chown -R 0:0 *
	chmod -R a+r-w+X,u+w *
}

src_compile() {
	emake nvsetenv || die
}

src_install() {
	into /usr
	dosbin nvsetenv || die
}
