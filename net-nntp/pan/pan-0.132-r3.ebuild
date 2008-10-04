# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/pan/pan-0.132-r3.ebuild,v 1.7 2008/10/04 11:11:38 eva Exp $

inherit eutils

DESCRIPTION="A newsreader for the Gnome2 desktop"
HOMEPAGE="http://pan.rebelbase.com/"
SRC_URI="http://pan.rebelbase.com/download/releases/${PV}/source/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="spell"

RDEPEND=">=dev-libs/glib-2.4.0
	>=x11-libs/gtk+-2.4.0
	>=dev-libs/libpcre-5.0
	=dev-libs/gmime-2.2*
	spell? ( >=app-text/gtkspell-2.0.7 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21
	dev-util/pkgconfig
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/load-pixbuf-in-1024-byte-chunks.diff

	# Fix compilation with >=glib-2.16, bug #214446
	epatch "${FILESDIR}"/${P}-glib-compat.patch

	# Fix compilation with gcc-4.3, bug #211670
	epatch "${FILESDIR}"/${P}-gcc43-fixes.patch

	# Security bug #224051
	epatch "${FILESDIR}"/${P}-CVE-2008-2363.patch
}

src_compile() {
	econf $(use_with spell gtkspell) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}
