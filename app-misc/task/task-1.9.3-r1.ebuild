# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/task/task-1.9.3-r1.ebuild,v 1.2 2011/02/09 13:04:04 phajdan.jr Exp $

EAPI=3

inherit eutils autotools

DESCRIPTION="A task management tool with a command-line interface"
HOMEPAGE="http://taskwarrior.org/projects/show/taskwarrior/"
SRC_URI="http://taskwarrior.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="bash-completion debug lua +ncurses vim-syntax zsh-completion"

DEPEND="lua? ( dev-lang/lua )
	ncurses? ( sys-libs/ncurses )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.9.2-configure.patch

	# Use the correct directory locations
	sed -i -e "s:/usr/local/share/doc/task/rc:/usr/share/task/rc:" src/Config.cpp \
		doc/man/taskrc.5 doc/man/task-tutorial.5 doc/man/task-color.5 || die "sed failed"
	sed -i -e "s:/usr/local/bin:/usr/bin:" doc/man/task-faq.5 || die "sed failed"

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
	emake DESTDIR="${D}" rcfiledir="/usr/share/task/rc" i18ndir="/usr/share/task" \
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
