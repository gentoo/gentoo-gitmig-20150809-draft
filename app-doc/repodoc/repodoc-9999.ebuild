# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/repodoc/repodoc-9999.ebuild,v 1.1 2007/05/07 22:56:05 yoswink Exp $

EGIT_REPO_URI="git://git.ferdyx.org/repodoc.git"
EGIT_BRANCH="next"
EGIT_BOOTSTRAP="./autogen.bash"

inherit git mono

DESCRIPTION="A tool designed to make checks on Gentoo official docs"
HOMEPAGE="http://dev.gentoo.org/~yoswink/repodoc/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gtk"

RDEPEND="${DEPEND}
	|| ( sys-apps/gawk sys-apps/mawk sys-apps/busybox )"

DEPEND="dev-libs/libxml2
	app-text/txt2tags
	gtk? ( dev-dotnet/gtk-sharp )"

src_compile() {
	econf $(use_enable gtk) || die 'econf failed!'
	emake || die 'emake failed!'
}

src_install() {
	make DESTDIR="${D}" install || die 'install failed!'
	dodoc AUTHORS ChangeLog
}
