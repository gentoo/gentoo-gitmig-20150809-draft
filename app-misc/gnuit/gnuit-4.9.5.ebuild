# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gnuit/gnuit-4.9.5.ebuild,v 1.3 2009/11/08 19:17:23 nixnut Exp $

EAPI="2"

DESCRIPTION="GNU Interactive Tools - increase speed and efficiency of most daily tasks"
HOMEPAGE="http://www.gnu.org/software/gnuit/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3 FDL-1.3"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

# app-text/texi2html is only needed if any documentation patches are added
# dev-util/git[gtk] installs the gitview tool which collides with this
# package.
DEPEND="!dev-util/git[gtk]"
RDEPEND="${DEPEND}"

src_configure() {
	# The transition option controls whether a "git" wrapper is installed, it is
	# disabled explicitly so we don't need to block on dev-util/git.
	econf --disable-transition
}

src_install() {
	emake DESTDIR="${D}" htmldir="/usr/share/doc/${PF}/html" install \
		|| die "emake install failed"
	dodoc AUTHORS NEWS PROBLEMS README
}

pkg_postinst() {
	elog "The 'git' tool this package previously installed is now called 'gitfm'"
	elog "If you want the 'gitaction' tool to use your preferred desktop"
	elog "application settings install the 'x11-misc/xdg-utils' package."
}
