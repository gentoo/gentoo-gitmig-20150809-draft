# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ee/ee-1.5.2.ebuild,v 1.1 2011/05/07 16:37:12 hattya Exp $

EAPI="3"

inherit eutils toolchain-funcs

IUSE=""

DESCRIPTION="An easy to use text editor. A subset of aee."
HOMEPAGE="http://mahon.cwx.net/"
SRC_URI="http://mahon.cwx.net/sources/${P}.src.tgz"

LICENSE="BSD-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos"
SLOT="0"
S="${WORKDIR}/easyedit-${PV}"

src_prepare() {

	epatch "${FILESDIR}"/${PN}-*.diff

	sed -i \
		-e "s/make -/\$(MAKE) -/g" \
		-e "/^buildee/s/$/ localmake/" \
		Makefile \
		|| die

	sed -i \
		-e "s/\tcc /\t\\\\\$(CC) /" \
		-e "/CFLAGS =/s/\" >/ \\\\\$(LDFLAGS)\" >/" \
		-e "/other_cflag/s/ *-s//" \
		create.make \
		|| die

}

src_compile() {

	emake CC="$(tc-getCC)" || die

}

src_install() {

	dobin ee
	doman ee.1
	dodoc Changes README.ee ee.i18n.guide ee.msg
	dodir /usr/share/${PN}

}
