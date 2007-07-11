# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/tk707/tk707-0.8.ebuild,v 1.3 2007/07/11 19:30:24 mr_bones_ Exp $

inherit eutils

DESCRIPTION=" An \"7x7\" type midi drum sequencer for Linux"
HOMEPAGE="http://www-lmc.imag.fr/lmc-edp/Pierre.Saramito/tk707"
SRC_URI="http://www-lmc.imag.fr/lmc-edp/Pierre.Saramito/tk707/download/${P}.tar.gz
		http://dev.gentoo.org/~jnc/files/${P}-updated_tcl2c.patch.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"

#IUSE="timidity lame"
IUSE=""

RDEPEND=">=media-libs/alsa-lib-0.9.0
		>=dev-lang/tcl-8.4
		>=dev-lang/tk-8.4"
#		timidity? ( media-sound/timidity++ )
#		lame? ( media-sound/lame )"
DEPEND="${RDEPEND}
		>=sys-devel/automake-1.7
		>=sys-devel/autoconf-2.5"

src_unpack() {
	unpack ${A}
	EPATCH_SOURCE=${S} epatch ${P}-*.patch
}

src_compile() {
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.7
	aclocal
	automake
	autoconf

	econf || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	einstall || die
}
