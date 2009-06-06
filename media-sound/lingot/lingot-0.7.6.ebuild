# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lingot/lingot-0.7.6.ebuild,v 1.5 2009/06/06 08:58:01 ssuominen Exp $

EAPI=2
WANT_AUTOMAKE=1.9
inherit autotools eutils

DESCRIPTION="LINGOT Is Not a Guitar-Only Tuner"
HOMEPAGE="http://www.nongnu.org/lingot"
SRC_URI="http://download.savannah.gnu.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

src_prepare() {
	epatch "${FILESDIR}"/${P}-clean-install.patch \
		"${FILESDIR}"/${P}-memory_leak.patch
	eautomake
}

src_configure() {
	econf \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" lingotdocdir="/usr/share/doc/${PF}" \
		install || die "emake install failed."
	prepalldocs
}
