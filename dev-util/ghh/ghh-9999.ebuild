# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ghh/ghh-9999.ebuild,v 1.1 2008/01/14 02:43:12 vapier Exp $

EGIT_REPO_URI="http://jean-francois.richard.name/ghh.git"
inherit git autotools

DESCRIPTION="a tool to track the history and make backups of your home directory"
HOMEPAGE="http://jean-francois.richard.name/ghh/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

# probably needs more/less crap listed here ...
RDEPEND="=x11-libs/gtk+-2*
	=dev-libs/glib-2*
	=gnome-base/libgnome-2*
	app-text/gnome-doc-utils
	dev-util/git
	dev-lang/python"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	git_src_unpack
	cd "${S}"
	NOCONFIGURE=yes ./autogen.sh || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog MAINTAINERS NEWS README TODO
}
