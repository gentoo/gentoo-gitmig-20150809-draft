# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ghh/ghh-9999.ebuild,v 1.6 2011/09/20 22:37:13 mgorny Exp $

EAPI=3
inherit autotools git-2

DESCRIPTION="a tool to track the history and make backups of your home directory"
HOMEPAGE="http://jean-francois.richard.name/ghh/"
EGIT_REPO_URI="git://github.com/jfrichard/git-home-history.git
	https://github.com/jfrichard/git-home-history.git"
EGIT_BOOTSTRAP="autogen.sh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

# probably needs more/less crap listed here ...
RDEPEND="x11-libs/gtk+:2
	dev-libs/glib:2
	gnome-base/libgnome
	app-text/gnome-doc-utils
	>=app-text/asciidoc-8
	dev-vcs/git
	dev-lang/python"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	NOCONFIGURE=yes git_src_prepare
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog MAINTAINERS NEWS README TODO
}
