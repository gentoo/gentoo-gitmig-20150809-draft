# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gsm/gsm-1.0.10.ebuild,v 1.1 2002/07/24 03:07:06 agenkin Exp $

DESCRIPTION="Lossy speech compression library and tool."
HOMEPAGE="http://kbs.cs.tu-berlin.de/~jutta/toast.html"
LICENSE="Other"

DEPEND="virtual/glibc"

S="${WORKDIR}/${PN}-$(echo ${PV} | sed 's/\.\([0-9]*\)$/-pl\1/')"
SRC_URI="ftp://ftp.cs.tu-berlin.de/pub/local/kbs/tubmik/gsm/${P}.tar.gz"

src_compile() {

	emake CCFLAGS="${CFLAGS} -c -DNeedFunctionPrototypes=1" || die

}

src_install() {

	dodir /usr/bin /usr/lib /usr/include /usr/share/man/man3 /usr/share/man/man1
	make INSTALL_ROOT="${D}/usr"			    \
		GSM_INSTALL_INC="${D}/usr/include"	    \
		GSM_INSTALL_MAN="${D}/usr/share/man/man3"   \
		TOAST_INSTALL_MAN="${D}/usr/share/man/man1" \
		install || die
	dodoc COPYRIGHT ChangeLog ChangeLog.orig MACHINES MANIFEST README

}
