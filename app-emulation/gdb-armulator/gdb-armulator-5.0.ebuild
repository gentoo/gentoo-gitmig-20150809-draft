# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/gdb-armulator/gdb-armulator-5.0.ebuild,v 1.4 2011/03/27 10:25:17 nirbheek Exp $

EAPI="1"

inherit flag-o-matic eutils

export CTARGET="arm-elf"

STAMP=20021127
DESCRIPTION="emulate armnommu/uClinux in GDB"
HOMEPAGE="http://www.uclinux.org/pub/uClinux/utilities/armulator/"
SRC_URI="http://ftp.gnu.org/gnu/gdb/gdb-${PV}.tar.bz2
	http://www.uclinux.org/pub/uClinux/utilities/armulator/gdb-${PV}.tar.bz2
	http://www.uclinux.org/pub/uClinux/utilities/armulator/gdb-${PV}-uclinux-armulator-${STAMP}.patch.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="-amd64 ~x86"
IUSE="nls"
RESTRICT="test"

RDEPEND="sys-libs/ncurses
	media-libs/freetype
	x11-libs/gtk+:2
	dev-libs/glib:2
	x11-libs/pango"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

S=${WORKDIR}/gdb-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/gdb-${PV}-uclinux-armulator-${STAMP}.patch
	epatch "${FILESDIR}"/${P}-objstack.patch #211463
	strip-linguas -u bfd/po opcodes/po

	# add a wrapper to fake gtk-1 with gtk-2
	mkdir "${T}"/path
	cp "${FILESDIR}"/gtk-config "${T}"/path/
}

src_compile() {
	export PATH=${T}/path:${PATH}
	replace-flags -O? -O2
	econf \
		--disable-werror \
		$(use_enable nls) \
		|| die
	emake || die
}

src_install() {
	newbin gdb/gdb ${PN} || die
}

pkg_postinst() {
	elog "For instructions on how to use this emulator, please see:"
	elog " ${HOMEPAGE}"
}
