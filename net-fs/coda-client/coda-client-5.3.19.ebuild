# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/coda-client/coda-client-5.3.19.ebuild,v 1.2 2002/10/24 20:52:19 lostlogic Exp $

IUSE=""
PN="coda"
#client and server dont come separately, just install separately
P="${PN}-${PV}"
DESCRIPTION="Coda is an advanced networked filesystem developed at Carnegie Mellon Univ."
HOMEPAGE="http://www.coda.cs.cmu.edu"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

# partly based on the deps suggested by Mandrake's RPM, and/or on my current versions
# Also, definely needs coda.h from linux-headers.
DEPEND="virtual/glibc
	>=sys-libs/lwp-1.9
	>=net-libs/rpc2-1.13
	>=sys-libs/rvm-1.6
	>=sys-libs/db-3
	>=sys-libs/ncurses-4
	>=sys-libs/readline-3
	>=sys-kernel/linux-headers-2.4"

SRC_URI="ftp://ftp.coda.cs.cmu.edu/pub/${PN}/src/${P}.tar.gz"

S=${WORKDIR}/${P}

src_unpack() {

	unpack ${A}

	cd ${S}
	# So that the venus initscript is Gentoo-compliant
	patch -p1 < ${FILESDIR}/${PF}-gentoo.patch || die "patch failed"
	patch -p1 < ${FILESDIR}/${PF}-gentoo2.patch || die "patch failed"

}

src_compile() {
	OCFLAGS="${CFLAGS}"
	CFLAGS="${CFLAGS} -lpthread"
	econf || die "configure failed"

	mv Makeconf.setup Makeconf.setup.orig
	sed -e "s:-lpthread::;s:-ldb:-ldb -lpthread:" \
		Makeconf.setup.orig > Makeconf.setup

	CFLAGS="${OCFLAGS}"
	MAKEOPTS="-j1" emake || die "emake failed"
}

src_install () {
	#these crazy makefiles dont seem to use DESTDIR, but they do use these... 
	# (except infodir, but no harm in leaving it there)
	# see Makeconf.setup in the package
	#
	#Also note that for Coda, need to do "make client-install" for client, or
	# "make server-install" for server.
	#...you can find out about this from ./configs/Makerules
	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc/coda \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		oldincludedir=${D}/usr/include client-install || die
}

pkg_postinst () {
	rc-update add venus.init default
	einfo
	einfo "I have already done:"
	einfo "   rc-update add venus.init default"
	einfo
}

pkg_prerm () {
	/etc/init.d/venus.init stop || /etc/init.d/venus.init hardstop
	rc-update del venus.init default
}
