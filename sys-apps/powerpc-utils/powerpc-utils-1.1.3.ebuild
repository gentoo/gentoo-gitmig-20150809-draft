# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Id: powerpc-utils-1.1.3.ebuild,v 1.4 2002/07/14 19:20:19 aliz Exp $

S=${WORKDIR}/${P}
DEBRV=3
DESCRIPTION="PowerPC utils; nvsetenv"
SRC_URI="http://http.us.debian.org/debian/pool/main/p/powerpc-utils/powerpc-utils_${PV}.orig.tar.gz
	http://http.us.debian.org/debian/pool/main/p/powerpc-utils/powerpc-utils_${PV}-${DEBRV}.diff.gz"
HOMEPAGE=""
KEYWORDS="ppc"
DEPEND="virtual/glibc"
RDEPEND=""
SLOT="0"
LICENSE="GPL"

pkg_setup() {
	if [ ${ARCH} != "ppc" ] ; then
		eerror "Sorry, this is a PPC only package."
		die "Sorry, this as a PPC only pacakge."		
	fi
}

src_unpack() {
	cd ${WORKDIR}
	unpack powerpc-utils_${PV}.orig.tar.gz
	mv pmac-utils ${P}
	cd ${S}
	cat ${DISTDIR}/powerpc-utils_${PV}-${DEBRV}.diff.gz | gzip -dc | patch -p1 || die
	cd ${WORKDIR}
	chown -R 0.0 *
	chmod -R a+r-w+X,u+w *
}

src_compile() {
	emake nvsetenv || die
}

src_install () {
	into /usr
	dosbin nvsetenv || die

}
