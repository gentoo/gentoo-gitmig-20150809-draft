# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xtrs/xtrs-4.9c-r1.ebuild,v 1.3 2008/04/27 12:40:00 maekke Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Radio Shack TRS-80 emulator"
HOMEPAGE="http://www.tim-mann.org/xtrs.html"
SRC_URI="http://www.tim-mann.org/trs80/${P}.tar.gz
	http://home.gwi.net/~plemon/support/disks/xtrs/ld4-631.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-libs/ncurses
	sys-libs/readline
	>=x11-libs/libX11-1.0.0"

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
	elog "For copyright reasons, xtrs does not include ROM images."
	elog "If you already own a copy of the ROM software (e.g., if you have"
	elog "a TRS-80 with this ROM), then you can make yourself a copy of this"
	elog "for use with xtrs. You can get such a copy also from elsewhere on"
	elog "the web. You may install the ROM images in directory /usr/share/xtrs"
	elog "as files \"romimage\", \"romimage.m3\", or \"romimage.m4p\", for"
	elog "Model I, III, or 4P, respectively. (Model 4 uses the same ROM image"
	elog "as Model III.) The files may be in Intel hex or binary format."
}
