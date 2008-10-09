# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wklej/wklej-0.1.5.ebuild,v 1.1 2008/10/09 18:23:50 cla Exp $

EAPI=1

inherit eutils

DESCRIPTION="A wklej.org submitter"
HOMEPAGE="http://wklej.org"
SRC_URI="http://wklej.org/m/apps/wklej-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+vim"

DEPEND="${RDEPEND}"
RDEPEND="dev-lang/python
	vim? ( app-editors/vim )"

pkg_setup() {
	if use vim && ! built_with_use app-editors/vim python; then
		eerror "app-editors/vim must be compiled with USE=python"
		die "app-editors/vim must be compiled with USE=python"
	fi
}

src_install() {
	if use vim; then
		insinto /usr/share/vim/vimfiles/plugin
		doins "${WORKDIR}"/${PN}.vim
	fi

	dobin "${WORKDIR}"/${PN}
}
