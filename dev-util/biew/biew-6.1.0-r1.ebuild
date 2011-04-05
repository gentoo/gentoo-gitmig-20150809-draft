# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/biew/biew-6.1.0-r1.ebuild,v 1.3 2011/04/05 15:30:44 signals Exp $

EAPI=4
inherit eutils flag-o-matic toolchain-funcs versionator

MY_P=${PN}-$(replace_all_version_separators "")

DESCRIPTION="A portable viewer of binary files, hexadecimal and disassembler modes."
HOMEPAGE="http://beye.sourceforge.net/"
SRC_URI="mirror://sourceforge/beye/${PV}/${MY_P}-src.tar.bz2"
S=${WORKDIR}/${MY_P}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gpm mmx sse"
REQUIRED_USE="mmx sse"

RDEPEND="gpm? ( sys-libs/gpm )"
DEPEND="${RDEPEND}"

pkg_setup() {
	append-flags -mmmx -msse #362043
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-610-fix_localedep-1.patch"
	epatch "${FILESDIR}/${PN}-610-portable_configure-1.patch"
	sed -i -e 's^man/man1/biew.1^share/man/man1/biew.1^' makefile || die "Failed to edit makefile."
}

src_configure() {
	if use gpm; then
		append-flags -DHAVE_MOUSE
	else
		append-flags -UHAVE_MOUSE
	fi
	./configure --datadir=/usr/share/${PN} \
		--prefix=/usr \
		--cc="$(tc-getCC)" \
		--ld="$(tc-getCC)" \
		--as="$(tc-getAS)" \
		--ranlib="$(tc-getRANLIB)" || die "configure failed."
}

src_compile() {
	emake LDFLAGS="${LDFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc doc/{biew_en,release,unix}.txt
}

pkg_postinst() {
	elog
	elog "Note: if you are upgrading from <=dev-util/biew-6.1.0 you will need"
	elog "to change the paths in the setup dialog (F9) from /usr/share/ to"
	elog "/usr/share/biew/ Alternatively, you can delete ~/.biewrc and it will"
	elog "automatically determine the correct locations on the next run."
	elog
}
