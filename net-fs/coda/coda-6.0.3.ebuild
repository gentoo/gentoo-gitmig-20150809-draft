# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/coda/coda-6.0.3.ebuild,v 1.5 2004/07/26 17:50:21 griffon26 Exp $

inherit eutils

IUSE="kerberos"

DESCRIPTION="Coda is an advanced networked filesystem developed at Carnegie Mellon Univ."
HOMEPAGE="http://www.coda.cs.cmu.edu"
SRC_URI="ftp://ftp.coda.cs.cmu.edu/pub/coda/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

# partly based on the deps suggested by Mandrake's RPM, and/or on my current versions
# Also, definely needs coda.h from linux-headers.
DEPEND=">=sys-apps/portage-2.0.47-r10
	>=sys-libs/lwp-1.10
	>=net-libs/rpc2-1.20
	>=sys-libs/rvm-1.8
	>=sys-libs/db-3
	>=sys-libs/ncurses-4
	>=sys-libs/readline-3
	>=sys-kernel/linux-headers-2.4
	>=dev-lang/perl-5.8
	kerberos? ( virtual/krb5 )"

#	>=sys-apps/sed-4
#	net-fs/coda-kernel


RDEPEND=">=sys-libs/lwp-1.10
	>=net-libs/rpc2-1.20
	>=sys-libs/rvm-1.8
	>=sys-libs/db-3
	>=sys-libs/ncurses-4
	>=sys-libs/readline-3
	kerberos? ( virtual/krb5 )"




src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/coda-6.0.3-iowr.patch
}

src_compile() {
	local myflags=""

	use kerberos && myflags="${myflags} --with-crypto"

	econf ${myflags} || die "configure failed"
	emake -j1 || die "emake failed"
}

src_install () {
	#these crazy makefiles dont seem to use DESTDIR, but they do use these... 
	# (except infodir, but no harm in leaving it there)
	# see Makeconf.setup in the package

	#Also note that for Coda, we need to do "make client-install" for
	# the client, and "make server-install" for the server.
	#...you can find out about this from ./configs/Makerules
	emake \
		CINIT-SCRIPTS="" \
		prefix=${D}/usr \
		sysconfdir=${D}/etc/coda \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		oldincludedir=${D}/usr/include client-install || die

	emake \
		SINIT-SCRIPTS="" \
		prefix=${D}/usr \
		sysconfdir=${D}/etc/coda \
		mandir=${D}/usr/share/man \
		oldincludedir=${D}/usr/include server-install || die
		infodir=${D}/usr/share/info \

	dodoc README* ChangeLog CREDITS LICENSE

	exeinto /etc/init.d
	doexe ${FILESDIR}/venus
	doexe ${FILESDIR}/coda-update
	doexe ${FILESDIR}/codasrv
	doexe ${FILESDIR}/auth2

	# We may use a conf.d/coda file at some point ?
#	insinto /etc/conf.d
#	newins ${FILESDIR}/coda.conf.d coda

	# I am not sure why coda misplaces this file...
	mv -f ${D}/etc/server.conf.ex ${D}/etc/coda/server.conf.ex

	sed -i -e "s,^#vicedir=/.*,vicedir=/var/lib/vice," \
		${D}/etc/coda/server.conf.ex

	sed -i -e "s,^#mountpoint=/.*,mountpoint=/mnt/coda," \
		${D}/etc/coda/venus.conf.ex

	dodir /var/lib/vice
	dodir /mnt/coda
	dodir /usr/coda
	dodir /usr/coda/spool

	diropts -m0700
	dodir /usr/coda/etc
	dodir /usr/coda/venus.cache
}

pkg_postinst () {
	einfo
	einfo "To enable the coda at boot up, please do:"
	einfo "    rc-update add venus default"
	einfo
	einfo "* To get started, run venus-setup and vice-setup"
	einfo
}
