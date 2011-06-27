# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vimpc/vimpc-9999.ebuild,v 1.1 2011/06/27 10:14:32 angelos Exp $

EAPI=4
inherit autotools subversion

DESCRIPTION="An ncurses based mpd client with vi like key bindings."
HOMEPAGE="http://vimpc.sourceforge.net/"
ESVN_REPO_URI="https://${PN}.svn.sourceforge.net/svnroot/${PN}/trunk"
ESVN_BOOTSTRAP="eautoreconf"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-libs/libpcre[cxx]
	media-libs/libmpdclient"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}

DOCS=( AUTHORS README )

src_configure() {
	econf --docdir="${EPREFIX}"/usr/share/doc/${PF}
}

src_install() {
	default

	# vimpc will look for help.txt
	docompress -x /usr/share/doc/${PF}/help.txt
}
