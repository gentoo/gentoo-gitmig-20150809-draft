# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/matchbox-common/matchbox-common-0.9.1.ebuild,v 1.2 2006/10/16 21:33:09 yvasilev Exp $

inherit versionator

DESCRIPTION="Common files used by matchbox-panel and matchbox-desktop packages"
HOMEPAGE="http://projects.o-hand.com/matchbox/"
SRC_URI="http://projects.o-hand.com/matchbox/sources/${PN}/$(get_version_component_range 1-2)/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
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
	dodir /etc/X11/Sessions
	echo "matchbox-session" > ${D}/etc/X11/Sessions/matchbox
	exeinto /etc/X11/Sessions
	doexe /etc/X11/Sessions/matchbox

	insinto /usr/share/xsessions
	doins ${FILESDIR}/MatchBox.desktop

	dodoc AUTHORS Changelog INSTALL NEWS README
}
