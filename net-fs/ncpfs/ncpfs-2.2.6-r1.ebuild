# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/ncpfs/ncpfs-2.2.6-r1.ebuild,v 1.2 2010/10/08 16:22:59 mabi Exp $

EAPI="2"

inherit eutils pam

DESCRIPTION="Provides Access to Netware services using the NCP protocol"
HOMEPAGE="ftp://platan.vc.cvut.cz/pub/linux/ncpfs/"
SRC_URI="ftp://platan.vc.cvut.cz/pub/linux/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="nls pam php"

DEPEND="nls? ( sys-devel/gettext )
	pam? ( virtual/pam )
	php? ( || ( dev-lang/php virtual/httpd-php ) )"

src_prepare() {
	# add patch for PHP extension sandbox violation
	epatch "${FILESDIR}"/${PN}-2.2.5-php.patch
	epatch "${FILESDIR}"/${P}-gcc4.patch
	epatch "${FILESDIR}"/${P}-missing-includes.patch
	sed -i '/ldconfig/d' lib/Makefile.in #273484
	# hack inject LDFLAGS into the build
	sed -i '/^LIBS/s:=:= @LDFLAGS@:' `find -name Makefile.in` || die
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_enable pam pam "$(getpam_mod_dir)") \
		$(use_enable php)
}

src_install() {
	dodir $(getpam_mod_dir) /usr/sbin /sbin
	emake DESTDIR="${D}" install || die
	dodoc FAQ README
}
