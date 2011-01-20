# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/aee/aee-2.2.15b.ebuild,v 1.1 2011/01/20 14:30:08 hattya Exp $

EAPI="3"

inherit eutils toolchain-funcs

IUSE="X"

DESCRIPTION="An easy to use text editor."
HOMEPAGE="http://mahon.cwx.net/"
SRC_URI="http://mahon.cwx.net/sources/${P}.tar.gz"

LICENSE="Artistic"
KEYWORDS="~x86"
SLOT="0"

DEPEND="X? ( x11-libs/libX11 )"

src_prepare() {

	epatch "${FILESDIR}"/${PN}-*.diff

	sed -i \
		-e "s/make -/\$(MAKE) -/g" \
		-e "/^buildaee/s/$/ localaee/" \
		-e "/^buildxae/s/$/ localxae/" \
		Makefile \
		|| die

	sed -i \
		-e "s/\([\t ]\)cc /\1\\\\\$(CC) /" \
		-e "/CFLAGS =/s/\" >/ \\\\\$(LDFLAGS)\" >/" \
		-e "/other_cflag/s/ \${strip_option}//" \
		create.mk.{aee,xae} \
		|| die

}

src_compile() {

	local target="aee"

	if use X; then
		target="both"
	fi

	emake ${target} || die

}

src_install() {

	dobin aee
	dosym aee /usr/bin/rae
	doman aee.1
	dodoc Changes README.aee aee.i18n.guide aee.msg

	insinto /usr/share/${PN}
	doins help.ae

	if use X; then
		dobin xae
		dosym xae /usr/bin/rxae
	fi

}
