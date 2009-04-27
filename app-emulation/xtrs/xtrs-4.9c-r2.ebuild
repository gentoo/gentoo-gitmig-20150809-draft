# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xtrs/xtrs-4.9c-r2.ebuild,v 1.5 2009/04/27 13:24:48 lavajoe Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Radio Shack TRS-80 emulator"
HOMEPAGE="http://www.tim-mann.org/xtrs.html"
SRC_URI="http://www.tim-mann.org/trs80/${P}.tar.gz
	http://home.gwi.net/~plemon/support/disks/xtrs/ld4-631.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-libs/ncurses
	sys-libs/readline
	>=x11-libs/libX11-1.0.0"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${P}.tar.gz
	tar xzf	"${DISTDIR}/ld4-631.tar.gz" disks || die "tar failed"

	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"
	epatch "${FILESDIR}/${P}-newdos-datetime.patch"
}

src_compile() {
	use ppc && append-flags -Dbig_endian
	emake CC="$(tc-getCC)" DEBUG="${CFLAGS}" \
		DISKDIR="-DDISKDIR='\"/usr/share/xtrs\"'" \
		DEFAULT_ROM="-DDEFAULT_ROM='\"/usr/share/xtrs/romimage\"' \
			-DDEFAULT_ROM3='\"/usr/share/xtrs/romimage.m3\"' \
			-DDEFAULT_ROM4P='\"/usr/share/xtrs/romimage.m4p\"'" \
		|| die "emake failed"
}

src_install() {
	dodir /usr/bin /usr/share/xtrs/disks /usr/share/man/man1
	emake PREFIX="${D}"/usr install || die "emake install failed"

	insopts -m0444
	insinto /usr/share/xtrs/disks
	doins cpmutil.dsk utility.dsk "${WORKDIR}"/disks/ld4-631.dsk
	dosym disks/ld4-631.dsk /usr/share/xtrs/disk4p-0
	dosym disks/utility.dsk /usr/share/xtrs/disk4p-1

	dodoc ChangeLog README xtrsrom4p.README cpmutil.html dskspec.html \
		|| die "dodoc failed"
}

pkg_postinst() {
	ewarn "For copyright reasons, xtrs does not include actual ROM images."
	ewarn "Because of this, unless you supply your own ROM, xtrs will"
	ewarn "not function in any mode except 'Model 4p' mode (a minimal"
	ewarn "free ROM is included for this), which can be run like this:"
	ewarn "    xtrs -model 4p"
	elog ""
	elog "If you already own a copy of the ROM software (e.g., if you have"
	elog "a TRS-80 with this ROM), then you can make yourself a copy of this"
	elog "for use with xtrs using utilities available on the web.  You can"
	elog "also often find various ROMs elsewhere.  To load your own ROM,"
	elog "specify the '-romfile' option."
}
