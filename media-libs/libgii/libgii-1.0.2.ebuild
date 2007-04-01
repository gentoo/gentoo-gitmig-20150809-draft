# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgii/libgii-1.0.2.ebuild,v 1.2 2007/04/01 06:43:48 drac Exp $

inherit autotools eutils

DESCRIPTION="Fast and safe graphics and drivers for about any graphics card to the Linux kernel (sometimes)"
HOMEPAGE="http://www.ggi-project.org"
SRC_URI="mirror://sourceforge/ggi/${P}.src.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="X"

RDEPEND="X? ( x11-libs/libX11 )
	>=sys-kernel/linux-headers-2.6.11"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.9.0-linux26-headers.patch
	# Modify configure check that tries to compile the cpuid instruction
	# to work on hardened compiler. Modified acinclude.m4.
	epatch "${FILESDIR}"/${P}-configure-cpuid-pic.patch
	# Since acinclude.m4 is modified, need to autoreconf.
	eautoreconf
}

src_compile() {
	econf $(use_with X x) $(use_enable X x)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ChangeLog* FAQ NEWS README
}

pkg_postinst() {
	elog
	elog "Be noted that API has been changed, and you need to run"
	elog "revdep-rebuild from gentoolkit to correct deps."
	elog
}
