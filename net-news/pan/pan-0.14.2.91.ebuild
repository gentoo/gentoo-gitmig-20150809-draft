# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/pan/pan-0.14.2.91.ebuild,v 1.4 2004/12/05 02:18:13 swegener Exp $

inherit libtool

IUSE="nls spell"

DESCRIPTION="A newsreader for the Gnome2 desktop"
SRC_URI="http://pan.rebelbase.com/download/releases/${PV}/SOURCE/${P}.tar.bz2"
HOMEPAGE="http://pan.rebelbase.com/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~hppa ~ppc ~sparc ~amd64"
SLOT="0"

RDEPEND=">=dev-libs/glib-2.0.4
	>=x11-libs/gtk+-2.0.5
	>=dev-libs/libxml2-2.4.22
	>=net-libs/gnet-1.1.8
	>=dev-libs/libpcre-4.0
	spell? ( >=app-text/gtkspell-2.0.2 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21
	sys-devel/gettext"

export CONFIG_PROTECT_MASK="/etc/gconf"

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
	cd ${S}

	elibtoolize || die "elibtoolize failed"
}

src_compile() {
	econf $(use_enable spell gtkspell) || die "Configure failure"
	emake || die "Compilation failure"
}

src_install() {
	make install DESTDIR=${D} || die "Installation failed"
	dodoc AUTHORS ChangeLog CREDITS NEWS README TODO || die "dodoc failed"
	dohtml ANNOUNCE.html docs/{pan-shortcuts,faq}.html || die "dodoc failed"
}
