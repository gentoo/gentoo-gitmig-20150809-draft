# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/serialmail/serialmail-0.75-r4.ebuild,v 1.1 2011/02/07 10:43:44 bangert Exp $

EAPI="3"

inherit eutils

DESCRIPTION="A serialmail is a collection of tools for passing mail across serial links."
HOMEPAGE="http://cr.yp.to/serialmail.html"
SRC_URI="http://cr.yp.to/software/${P}.tar.gz
	mirror://gentoo/${P}-patch.tar.bz2"

DEPEND="sys-apps/groff
	>=sys-apps/ucspi-tcp-0.88"

RDEPEND="sys-apps/groff
	>=sys-apps/ucspi-tcp-0.88
	virtual/daemontools"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="static"

src_prepare() {
	epatch "${WORKDIR}"/${P}-gentoo.patch
	epatch "${WORKDIR}"/${P}-smtpauth.patch
	epatch "${WORKDIR}"/${P}-smtpauth_comp.patch
	sed -i "s:@CFLAGS@:${CFLAGS}:" conf-cc
	use static && LDFLAGS="${LDFLAGS} -static"
	sed -i "s:@LDFLAGS@:${LDFLAGS}:" conf-ld
}

src_compile() {
	grep -v man hier.c | grep -v doc > hier.c.tmp ; mv hier.c.tmp hier.c
	emake it man || die
}

src_install() {
	dobin serialsmtp serialqmtp maildirsmtp maildirserial maildirqmtp

	dodoc AUTOTURN CHANGES FROMISP SYSDEPS THANKS TOISP \
		BLURB FILES INSTALL README TARGETS TODO VERSION

	doman maildirqmtp.1 maildirserial.1 maildirsmtp.1 \
		serialqmtp.1 serialsmtp.1
}
