# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gsm/gsm-1.0.10.ebuild,v 1.6 2004/02/15 12:51:31 dholm Exp $

S="${WORKDIR}/${PN}-$(echo ${PV} | sed 's/\.\([0-9]*\)$/-pl\1/')"
DESCRIPTION="Lossy speech compression library and tool."
HOMEPAGE="http://kbs.cs.tu-berlin.de/~jutta/toast.html"
SRC_URI="ftp://ftp.cs.tu-berlin.de/pub/local/kbs/tubmik/gsm/${P}.tar.gz"

SLOT="0"
LICENSE="OSI-Approved"
KEYWORDS="x86 ~amd64 ~ppc"

DEPEND="virtual/glibc"

src_compile() {

	emake CCFLAGS="${CFLAGS} -c -DNeedFunctionPrototypes=1" || die

}

src_install() {

	dodir /usr/bin /usr/lib /usr/include /usr/share/man/man{1,3}
	make INSTALL_ROOT="${D}/usr" \
		GSM_INSTALL_INC="${D}/usr/include" \
		GSM_INSTALL_MAN="${D}/usr/share/man/man3" \
		TOAST_INSTALL_MAN="${D}/usr/share/man/man1" \
		install || die

	dodoc COPYRIGHT ChangeLog* MACHINES MANIFEST README
}
