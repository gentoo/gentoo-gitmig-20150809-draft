# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/linesrv/linesrv-2.1.21-r1.ebuild,v 1.5 2006/03/12 16:34:09 mrness Exp $

inherit webapp flag-o-matic

DESCRIPTION="Client/Server system to control the Internet link of a masquerading server"
HOMEPAGE="http://linecontrol.srf.ch/"
SRC_URI="http://linecontrol.srf.ch/down/${P}.src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc x86"
# if someone disables pam but wants user authentication
# to be supported, then crypt is needed.
IUSE="pam mysql crypt"

# requesting glibc instead of virtual/libc
# because we might need crypt. And as far as I
# (S. Fuchs, author of linesrv) remember, there's
# glibc specific stuff in linesrv.
DEPEND=">=sys-libs/glibc-2.2.0
	pam? ( >=sys-libs/pam-0.75 )
	mysql? ( >=dev-db/mysql-4 )"

S="${WORKDIR}/${PN}-${PV%.*}"

WEBAPP_MANUAL_SLOT=yes

src_unpack() {
	unpack ${A}

	sed -i -e 's:/etc/linesrv.conf:/etc/linesrv/linesrv.conf:' \
		"${S}/server/cfg.h" \
		"${S}/lclog/lclog.c" \
		"${S}/htmlstatus/htmlstatus.c"
	sed -i -e 's:^CFLAGS *=:CFLAGS = @CFLAGS@:' \
		"${S}/server/Makefile.in" #set user CFLAGS 
}

src_compile() {
	append-ldflags $(bindnow-flags) #don't use lazy bindings

	local myconf=""
	# sfuchs: configure script of linesrv 2 is quite bad...
	# prefer pam, if disabled try crypt
	# the configure script will disable authentication if
	# neither pam nor crypt is available.
	if ! use pam ; then
		myconf="${myconf} --disable-pamauth"
		if use crypt; then
			myconf="${myconf} --enable-cryptauth"
		fi
	fi
	# --enable-mysql is not supported... stupid, I know.
	use mysql || myconf="${myconf} --disable-mysql"
	econf ${myconf} || die "bad configure"
	emake || die "build failed"
}

src_install() {
	webapp_src_preinst
	dodir /usr/share/linesrv /var/log/linesrv

	dosbin server/linesrv

	mknod "${D}/usr/share/linesrv/logpipe" p
	exeinto /usr/share/linesrv ; doexe server/config/complete_syntax/halt-wrapper

	doman debian/*.{5,8}

	dodoc server/{INSTALL,NEWS,README}
	newdoc htmlstatus/README README.htmlstatus
	newdoc lclog/INSTALL INSTALL.lclog
	newdoc "${FILESDIR}/linesrv.conf" linesrv.conf.sample
	docinto complete_syntax ; dodoc server/config/complete_syntax/*

	insinto /etc/linesrv ; newins "${FILESDIR}/linesrv.conf" linesrv.conf
	newinitd "${FILESDIR}/linesrv.rc6" linesrv
	if use pam ; then
		insinto /etc/pam.d
		newins "${FILESDIR}/linecontrol.pam" linecontrol
		newins "${FILESDIR}/lcshutdown.pam" lcshutdown
	fi

	exeinto "${MY_CGIBINDIR}" ; doexe lclog/lclog htmlstatus/htmlstatus
	insinto "${MY_HTDOCSDIR}/lclog" ; doins lclog/html/*
	webapp_src_install
}

pkg_postinst() {
	einfo "The first stage of the installation is done. Now you need to setup your virtual hosts via webapp-config"
	einfo "Please read man webapp-config for a detailed description of the process and some examples"
	webapp_pkg_postinst
}
