# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/task/task-1.9.3.ebuild,v 1.1 2010/11/09 07:32:56 radhermit Exp $

EAPI=3

inherit eutils autotools

MY_P="${P/_/.}"
DESCRIPTION="A task management tool with a command-line interface"
HOMEPAGE="http://taskwarrior.org/projects/show/taskwarrior/"
SRC_URI="http://taskwarrior.org/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion debug lua +ncurses vim-syntax zsh-completion"

DEPEND="lua? ( dev-lang/lua )
	ncurses? ( sys-libs/ncurses )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.9.2-configure.patch
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
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
