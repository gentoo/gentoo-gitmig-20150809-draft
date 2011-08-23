# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/aee/aee-2.2.15b.ebuild,v 1.3 2011/08/23 12:33:28 hattya Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="An easy to use text editor."
HOMEPAGE="http://mahon.cwx.net/"
SRC_URI="http://mahon.cwx.net/sources/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="X"

RDEPEND="X? ( x11-libs/libX11 )"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-*.diff

	sed -i \
		-e "s/make -/\$(MAKE) -/g" \
		-e "/^buildaee/s/$/ localaee/" \
		-e "/^buildxae/s/$/ localxae/" \
		Makefile

	sed -i \
		-e "s/\([\t ]\)cc /\1\\\\\$(CC) /" \
		-e "/CFLAGS =/s/\" >/ \\\\\$(LDFLAGS)\" >/" \
		-e "/other_cflag/s/ \${strip_option}//" \
		create.mk.{aee,xae}
}

src_compile() {
	local target="aee"
	use X && target="both"

	emake ${target}
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
