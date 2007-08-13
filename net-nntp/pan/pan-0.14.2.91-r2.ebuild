# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/pan/pan-0.14.2.91-r2.ebuild,v 1.4 2007/08/13 21:50:39 dertobi123 Exp $

inherit eutils libtool

IUSE="nls spell"

DESCRIPTION="A newsreader for the Gnome2 desktop"
SRC_URI="http://pan.rebelbase.com/download/releases/${PV}/SOURCE/${P}.tar.bz2"
HOMEPAGE="http://pan.rebelbase.com/"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ppc ppc64 ~sparc ~x86"
SLOT="0"

RDEPEND=">=dev-libs/glib-2.0.4
	>=x11-libs/gtk+-2.0.5
	>=dev-libs/libxml2-2.4.22
	>=net-libs/gnet-1.1.8
	>=dev-libs/libpcre-4.0
	spell? ( >=app-text/gtkspell-2.0.2 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	# Likely that glibc might of been compiled with nls turned off.
	# Warn people that Pan requires glibc to have nls support.
	if ! use nls
	then
		ewarn "Pan requires glibc to be merged with 'nls' in your USE flags."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix for building with gcc4
	epatch "${FILESDIR}"/${P}-gcc4-2.patch

	elibtoolize || die "elibtoolize failed"
}

src_compile() {
	econf $(use_enable spell gtkspell) || die "Configure failure"
	emake || die "Compilation failure"
}

src_install() {
	make install DESTDIR="${D}" || die "Installation failed"
	dodoc AUTHORS ChangeLog CREDITS NEWS README TODO || die "dodoc failed"
	dohtml ANNOUNCE.html docs/{pan-shortcuts,faq}.html || die "dodoc failed"
}
