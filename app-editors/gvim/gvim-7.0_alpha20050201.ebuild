# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gvim/gvim-7.0_alpha20050201.ebuild,v 1.1 2005/02/01 19:16:20 ciaranm Exp $

inherit vim

VIM_DATESTAMP="${PV##*alpha}"
VIM_PATCHES_DATESTAMP="20050201"

VIM_VERSION="7.0aa"
VIM_SNAPSHOT="vim-${VIM_VERSION}-${VIM_DATESTAMP}.tar.bz2"
VIM_GENTOO_PATCHES="vim-${VIM_VERSION}-${VIM_PATCHES_DATESTAMP:-${VIM_DATESTAMP}}-gentoo-patches.tar.bz2"

SRC_URI="${SRC_URI}
	mirror://gentoo/${VIM_SNAPSHOT}
	mirror://gentoo/${VIM_GENTOO_PATCHES}"

S=${WORKDIR}/vim${VIM_VERSION/.*}
DESCRIPTION="GUI version of the Vim text editor"
KEYWORDS="~x86 ~sparc ~mips ~ppc ~amd64 ~alpha"
IUSE="${IUSE} gnome gtk gtk2 motif nextaw qt"
PROVIDE="virtual/editor"
DEPEND="${DEPEND}
	~app-editors/vim-core-${PV}
	virtual/x11
	!aqua? (
		gtk? (
			gtk2? (
				>=x11-libs/gtk+-2.4
				virtual/xft
				gnome? ( >=gnome-base/libgnomeui-2.6 )
			)
			!gtk2? (
				gnome? ( gnome-base/gnome-libs )
				!gnome? ( =x11-libs/gtk+-1.2* )
			)
		)
		!gtk? (
			qt? (
				>=kde-base/kdelibs-3.3.1
			)
			!qt? (
				motif? (
					x11-libs/openmotif
				)
				!motif? (
					nextaw? (
						x11-libs/neXtaw
					)
				)
			)
		)
	)"
