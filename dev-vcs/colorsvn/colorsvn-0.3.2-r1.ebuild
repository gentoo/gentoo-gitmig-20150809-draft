# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/colorsvn/colorsvn-0.3.2-r1.ebuild,v 1.2 2010/06/22 18:43:26 arfrever Exp $

DESCRIPTION="Subversion output colorizer"
HOMEPAGE="http://colorsvn.tigris.org"
SRC_URI="http://www.console-colors.de/downloads/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-vcs/subversion"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# rxvt-unicode isn't listed by default :)
	sed -i -e 's:rxvt:rxvt rxvt-unicode:' colorsvnrc-original || die

	# Do not colorize "svn mkdir", bug 321451
	sed -i -e 's:\("resolved", "revert", "unlock"\):\1, "mkdir":' colorsvn-original || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CREDITS || die "dodoc failed"
}

pkg_postinst() {
	einfo
	einfo "The default settings are stored in /etc/colorsvnrc."
	einfo "They can be locally overridden by ~/.colorsvnrc."
	einfo "An alias to colorsvn was installed for the svn command."
	einfo "In order to immediately activate it do:"
	einfo "\tsource /etc/profile"
	einfo "NOTE: If you don't see colors,"
	einfo "append the output of 'echo \$TERM' to 'colortty' in your colorsvnrc."
	einfo
}
