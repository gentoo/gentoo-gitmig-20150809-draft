# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gvim/gvim-7.0.235.ebuild,v 1.16 2009/01/04 22:43:51 ulm Exp $

inherit vim

VIM_VERSION="7.0"
VIM_SNAPSHOT="vim-7.0-r1.tar.bz2"
VIM_GENTOO_PATCHES="vim-7.0-gentoo-patches-r1.tar.bz2"
VIM_ORG_PATCHES="vim-patches-${PV}.tar.gz"
GVIMRC_FILE_SUFFIX="-r1"

SRC_URI="${SRC_URI}
	mirror://gentoo/${VIM_SNAPSHOT}
	mirror://gentoo/${VIM_GENTOO_PATCHES}
	mirror://gentoo/${VIM_ORG_PATCHES}"

S=${WORKDIR}/vim${VIM_VERSION/.*}
DESCRIPTION="GUI version of the Vim text editor"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="aqua gnome gtk motif nextaw"
DEPEND="${DEPEND}
	~app-editors/vim-core-${PV}
	x11-libs/libXext
	!aqua? (
		gtk? (
			>=x11-libs/gtk+-2.6
			x11-libs/libXft
			gnome? ( >=gnome-base/libgnomeui-2.6 )
		)
		!gtk? (
			motif? (
				x11-libs/openmotif
			)
			!motif? (
				nextaw? (
					x11-libs/neXtaw
				)
				!nextaw? ( x11-libs/libXaw )
			)
		)
	)"
