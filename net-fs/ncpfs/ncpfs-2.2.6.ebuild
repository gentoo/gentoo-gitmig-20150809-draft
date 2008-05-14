# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/ncpfs/ncpfs-2.2.6.ebuild,v 1.5 2008/05/14 22:16:53 flameeyes Exp $

inherit eutils confutils

IUSE="nls pam php"

DESCRIPTION="Provides Access to Netware services using the NCP protocol (Kernel support must be activated!)"
SRC_URI="ftp://platan.vc.cvut.cz/pub/linux/${PN}/${P}.tar.gz"
HOMEPAGE="ftp://platan.vc.cvut.cz/pub/linux/ncpfs/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ~ppc ppc64"

DEPEND="nls? ( sys-devel/gettext )
		pam? ( virtual/pam )
		php? ( || ( virtual/php virtual/httpd-php ) )"

src_unpack() {
	unpack ${A}

	# add patch for PHP extension sandbox violation
	cd ${S} || die "Unable to cd to ${S}"
	epatch "${FILESDIR}"/${PN}-2.2.5-php.patch || die "Unable to apply PHP patch"
	epatch "${FILESDIR}"/${P}-gcc4.patch
	epatch "${FILESDIR}"/${P}-missing-includes.patch
}

src_compile() {

	local myconf

	myconf=
	enable_extension_enable "nls" "nls" 0
	enable_extension_enable "pam" "pam" 0
	enable_extension_enable "php" "php" 0

	econf ${myconf} || die "econf failed"
	emake || die
}

src_install () {
	# directory ${D}/lib/security needs to be created or the install fails
	dodir /lib/security
	dodir /usr/sbin
	dodir /sbin
	make DESTDIR=${D} install || die

	dodoc FAQ README
}
