# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/nestra/nestra-0.66-r1.ebuild,v 1.4 2005/03/21 08:10:09 eradicator Exp $

inherit eutils games toolchain-funcs flag-o-matic

PATCH="${P/-/_}-7.diff"
DESCRIPTION="NES emulation for Linux/x86"
HOMEPAGE="http://nestra.linuxgames.com/"
SRC_URI="http://nestra.linuxgames.com/${P}.tar.gz
	mirror://debian/pool/contrib/n/nestra/${PATCH}.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.2-r7 )"

DEPEND="${RDEPEND}
	virtual/x11"

S="${WORKDIR}/${PN}"

pkg_setup() {
	if use amd64; then
		if has_multilib_profile; then
			ABI_ALLOW="x86"

			# And until we get a real multilib portage...
			ABI="x86"

			# Yeah, this is ugly, but so's their build system...
			append-flags "-L/emul/linux/x86/usr/lib -L/emul/linux/x86/lib -L/usr/lib32 -L/lib32"
			append-ldflags $(get_abi_LDFLAGS)
		elif has_m32 ; then
			einfo "multilib detected, adding -m32 to CFLAGS."
			append-flags -m32
		else
			die "${PN} requires multilib support in gcc. please re-emerge gcc with multilib in USE and try again"
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}/${PATCH}"
	sed -i \
		-e 's:-O2 ::' \
		-e "s:ld:$(tc-getLD) ${LDFLAGS}:" \
		-e "s:gcc:$(tc-getCC) ${CFLAGS}:" Makefile \
		|| die "sed Makefile failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dogamesbin nestra || die "dogamesbin failed"
	dodoc BUGS CHANGES README
	doman nestra.6
	prepgamesdirs
}
