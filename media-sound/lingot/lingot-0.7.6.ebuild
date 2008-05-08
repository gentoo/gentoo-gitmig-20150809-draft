# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lingot/lingot-0.7.6.ebuild,v 1.1 2008/05/08 11:10:51 drac Exp $

WANT_AUTOMAKE=1.9

inherit autotools eutils

DESCRIPTION="LINGOT Is Not a Guitar-Only Tuner"
HOMEPAGE="http://www.nongnu.org/lingot"
SRC_URI="http://download.savannah.gnu.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-clean-install.patch
	eautomake
}

src_compile() {
	econf --disable-dependency-tracking
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" libgotdocdir="/usr/share/doc/${PF}" \
		install || die "emake install failed."
	prepalldocs
}
