# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/grip/grip-3.0.7.ebuild,v 1.1 2003/04/24 03:52:43 agenkin Exp $

inherit eutils

DESCRIPTION="GTK+ based Audio CD Player/Ripper."
HOMEPAGE="http://www.nostatic.org/grip"
LICENSE="GPL-2"

DEPEND="=x11-libs/gtk+-1.2*
	=sys-libs/db-1*
	media-sound/lame
	media-sound/cdparanoia
	media-libs/id3lib
	gnome-base/gnome-libs
	gnome-base/ORBit
	gnome-base/libghttp
	oggvorbis? ( media-sound/vorbis-tools )
	nls? ( sys-devel/gettext )"

IUSE="nls oggvorbis"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"

SRC_URI="http://www.nostatic.org/grip/${P}.tar.gz"
S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}

	# The NPTL pthreads implementation do not support the
	# pthread_kill_other_threads_np function, as its a true
	# posix threading library .. patch grip thus to use
	# pthread_kill if we are using NPTL.
	#
	# <azarah@gentoo.org> (06 March 2003)
	if have_NPTL
	then
		cd ${S}; epatch ${FILESDIR}/${P}-NPTL-compat.patch
	fi
}

src_compile() {
	local myconf=
	use nls || myconf="--disable-nls"

	econf ${myconf} || die
	emake || die
}

src_install () {
	einstall || die

	dodoc ABOUT-NLS AUTHORS CREDITS COPYING ChangeLog README TODO NEWS
}
