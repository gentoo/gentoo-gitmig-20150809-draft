# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim-core/vim-core-7.0.ebuild,v 1.2 2006/05/08 13:11:33 fmccor Exp $

inherit vim

VIM_VERSION="7.0"
VIM_SNAPSHOT="vim-7.0.tar.bz2"
VIM_GENTOO_PATCHES="vim-7.0-gentoo-patches.tar.bz2"
VIMRC_FILE_SUFFIX="-r3"

SRC_URI="${SRC_URI}
	mirror://gentoo/${VIM_SNAPSHOT}
	mirror://gentoo/${VIM_GENTOO_PATCHES}"

S=${WORKDIR}/vim${VIM_VERSION/.*}
DESCRIPTION="vim and gvim shared files"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND="${DEPEND}"
PDEPEND="!livecd? ( app-vim/gentoo-syntax )"
