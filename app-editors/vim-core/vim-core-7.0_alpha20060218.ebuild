# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim-core/vim-core-7.0_alpha20060218.ebuild,v 1.1 2006/02/18 03:43:02 ciaranm Exp $

inherit vim

VIM_DATESTAMP="${PV##*alpha}"

VIM_VERSION="7.0aa"
VIM_SNAPSHOT="vim-${PV}.tar.bz2"
VIM_GENTOO_PATCHES="vim-7.0_alpha20051207-gentoo-patches.tar.bz2"
VIMRC_FILE_SUFFIX="-r2"

SRC_URI="${SRC_URI}
	mirror://gentoo/${VIM_SNAPSHOT}
	mirror://gentoo/${VIM_GENTOO_PATCHES}"

S=${WORKDIR}/vim${VIM_VERSION/.*}
DESCRIPTION="vim, gvim and kvim shared files"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND="${DEPEND}" # done via the eclass
PDEPEND="!livecd? ( app-vim/gentoo-syntax )"
