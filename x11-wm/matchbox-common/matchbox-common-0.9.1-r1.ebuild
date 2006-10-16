# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/matchbox-common/matchbox-common-0.9.1-r1.ebuild,v 1.3 2006/10/16 21:33:09 yvasilev Exp $

inherit eutils versionator

DESCRIPTION="Common files used by matchbox-panel and matchbox-desktop packages"
HOMEPAGE="http://projects.o-hand.com/matchbox/"
SRC_URI="http://projects.o-hand.com/matchbox/sources/${PN}/$(get_version_component_range 1-2)/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~arm"
IUSE=""

DEPEND=">=x11-libs/libmatchbox-1.1"

src_compile() {
	econf --disable-pda-folders \
		|| die "Configuration failed"

	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	# Insert our Xsession
	echo -e "#!/bin/sh\n\nmatchbox-session" > ${T}/matchbox
	exeinto /etc/X11/Sessions
	doexe ${T}/matchbox

	# Insert GDM/KDM xsession file
	wm=matchbox make_session_desktop MatchBox matchbox-session

	dodoc AUTHORS Changelog INSTALL NEWS README
}
