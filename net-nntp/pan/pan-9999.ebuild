# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/pan/pan-9999.ebuild,v 1.2 2008/10/04 11:11:38 eva Exp $

inherit autotools subversion

DESCRIPTION="A newsreader for the Gnome2 desktop"
HOMEPAGE="http://pan.rebelbase.com/"

ESVN_REPO_URI="http://svn.gnome.org/svn/pan2/trunk"
ESVN_STORE_DIR="${PORTAGE_ACTUAL_DISTDIR-${DISTDIR}}"
# maximum svn update frequency, hours
ESVN_UP_FREQ="${ESVN_UP_FREQ:-1}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
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

	# The normal version tree ebuild we are based on (for patching)
	Pnorm="${PN}-0.132"

src_unpack() {
	subversion_src_unpack
	cd "${S}"

	# bootstrap build system
	intltoolize --force || die "intltoolize failed"
	eautoreconf
}

src_compile() {
	econf $(use_with spell gtkspell)
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}
