# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libqalculate/libqalculate-0.9.6.ebuild,v 1.1 2007/07/09 15:44:46 markusle Exp $

inherit eutils

DESCRIPTION="A modern multi-purpose calculator library"
LICENSE="GPL-2"
HOMEPAGE="http://qalculate.sourceforge.net/"
SRC_URI="mirror://sourceforge/qalculate/${P}.tar.gz"

SLOT="0"
IUSE="readline"
KEYWORDS="~amd64 ~sparc ~x86"

COMMON_DEPEND=">=sci-libs/cln-1.1
	dev-libs/libxml2
	>=dev-libs/glib-2.4
	sys-libs/zlib
	readline? ( sys-libs/readline )"

DEPEND="${COMMON_DEPEND}
	>=dev-util/pkgconfig-0.12.0
	dev-util/intltool
	sys-devel/gettext"

RDEPEND="${COMMON_DEPEND}
	>=sci-visualization/gnuplot-3.7
	net-misc/wget"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-check-fix.patch
}

src_compile() {
	# The CLN test is buggy and will often fail though an appropriate version
	# of the library is installed.
	CONFIG="$(use_with readline) --disable-clntest"
	econf ${CONFIG} || die "Configuration failed."
	emake || die "Compilation failed."
}

src_install() {
	einstall || die "Installation failed."
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	dodoc ${DOCS} || die "Documentation installation failed."
}
