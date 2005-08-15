# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libqalculate/libqalculate-0.8.1.1.ebuild,v 1.1 2005/08/15 23:56:39 ribosome Exp $

DESCRIPTION="A modern multi-purpose calculator library"
HOMEPAGE="http://qalculate.sourceforge.net/"
SRC_URI="mirror://sourceforge/qalculate/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE="nls readline"

DEPEND=">=sci-libs/cln-1.1
	dev-libs/libxml2
	>=dev-libs/glib-2.4
	>=media-gfx/gnuplot-3.7
	net-misc/wget
	nls? ( sys-devel/gettext )
	readline? ( sys-libs/readline )"

RDEPEND="dev-lang/perl
	dev-perl/XML-Parser
	>=dev-util/pkgconfig-0.12.0"

src_compile() {
	CONFIG="$(use_with readline)"
	econf ${CONFIG} || die
	emake || die
}

src_install() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	einstall || die
	dodoc ${DOCS}
}
