# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/matchbox-keyboard/matchbox-keyboard-0.1.ebuild,v 1.8 2010/04/15 13:11:26 yvasilev Exp $

inherit versionator eutils

DESCRIPTION="Matchbox-keyboard is an on screen 'virtual' or 'software' keyboard."
HOMEPAGE="http://matchbox-project.org/"
SRC_URI="http://matchbox-project.org/sources/${PN}/$(get_version_component_range 1-2)/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~arm ~hppa ~ppc ~x86"
IUSE="debug cairo"

DEPEND="x11-libs/libfakekey
	cairo? ( x11-libs/cairo )
	!cairo? ( x11-libs/libXft )"

pkg_setup() {
	if use cairo && ! built_with_use x11-libs/cairo X ; then
		eerror "In order to install ${PN} with cairo support you"
		eerror "need to reinstall x11-libs/cairo with USE='X'."
		die "x11-libs/cairo built without USE='X'"
	fi
}

src_compile() {
	econf	$(use_enable debug) \
		$(use_enable cairo) \
		|| die "Configuration failed"

	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
