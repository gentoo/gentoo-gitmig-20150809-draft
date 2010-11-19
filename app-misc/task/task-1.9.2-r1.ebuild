# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/task/task-1.9.2-r1.ebuild,v 1.3 2010/11/19 20:10:39 hwoarang Exp $

EAPI=3

inherit eutils autotools

DESCRIPTION="A task management tool with a command-line interface"
HOMEPAGE="http://taskwarrior.org/projects/show/taskwarrior/"
SRC_URI="http://www.taskwarrior.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="bash-completion debug lua +ncurses vim-syntax zsh-completion"

DEPEND="lua? ( dev-lang/lua )
	ncurses? ( sys-libs/ncurses )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-configure.patch
	eautoreconf
}

src_configure() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		$(use_enable debug ) \
		$(use_with lua) \
		$(use_with ncurses)
}

src_install() {
	emake DESTDIR="${D}" \
		bashscriptsdir="" vimscriptsdir="" zshscriptsdir="" \
		install || die "emake install failed"

	if use bash-completion ; then
		insinto /usr/share/bash-completion
		doins scripts/bash/*
	fi

	if use vim-syntax ; then
		rm scripts/vim/README
		insinto /usr/share/vim/vimfiles
		doins -r scripts/vim/*
	fi

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		doins scripts/zsh/*
	fi
}
