# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/its4/its4-1.1.1.ebuild,v 1.2 2004/10/17 09:48:42 dholm Exp $

DESCRIPTION="ITS4: Software Security Tool"
HOMEPAGE="http://www.cigital.com/its4/"
SRC_URI="${P}.tgz"
LICENSE="ITS4"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="sys-devel/gcc virtual/libc"
RESTRICT="nomirror fetch"
#RDEPEND=""
S="${WORKDIR}/${PN}"

pkg_nofetch() {
	einfo "Please visit ${HOMEPAGE} to download the source, and place it in"
	einfo "${DISTDIR}"
}

src_compile() {
	# WARNING
	# non-standard configure
	# do NOT use econf
	./configure --prefix=/usr --mandir=/usr/share/man --datadir=/usr/share/its4 || die "configure failed"
	emake OPTIMIZATION="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	# WARNING
	# non-standard, do NOT use einstall or 'make install DESTDIR=...'
	make install INSTALL_BINDIR="${D}/usr/bin" INSTALL_MANDIR="${D}/usr/share/man" INSTALL_DATADIR="${D}/usr/share/its4" || die "install failed"
}
