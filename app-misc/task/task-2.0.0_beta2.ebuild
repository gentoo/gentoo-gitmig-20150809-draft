# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/task/task-2.0.0_beta2.ebuild,v 1.1 2011/09/22 06:27:48 radhermit Exp $

EAPI=4

inherit eutils cmake-utils bash-completion-r1

MY_P="${P/_/.}"
DESCRIPTION="A task management tool with a command-line interface"
HOMEPAGE="http://taskwarrior.org/projects/show/taskwarrior/"
SRC_URI="http://taskwarrior.org/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lua vim-syntax zsh-completion"

DEPEND="lua? ( dev-lang/lua )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# Use the correct directory locations
	sed -i -e "s:/usr/local/share/doc/task/rc:/usr/share/task/rc:" \
		doc/man/taskrc.5.in doc/man/task-tutorial.5.in doc/man/task-color.5.in
	sed -i -e "s:/usr/local/bin:/usr/bin:" doc/man/task-faq.5.in scripts/add-ons/*

	# Don't automatically install scripts
	sed -i -e '/scripts/d' CMakeLists.txt

	epatch "${FILESDIR}"/${PN}-2.0.0_beta1-rcdir.patch \
		"${FILESDIR}"/${PN}-1.9.4-lua-automagic.patch
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable lua LUA)
		-DTASK_DOCDIR=/usr/share/doc/${PF}
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	newbashcomp scripts/bash/task_completion.sh task

	if use vim-syntax ; then
		rm scripts/vim/README
		insinto /usr/share/vim/vimfiles
		doins -r scripts/vim/*
	fi

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		doins scripts/zsh/*
	fi

	exeinto /usr/share/${PN}/scripts
	doexe scripts/add-ons/*
}
