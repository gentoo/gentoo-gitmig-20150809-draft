# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpg321/mpg321-0.2.10-r1.ebuild,v 1.8 2003/09/07 00:06:06 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Free MP3 player, drop-in replacement for mpg123"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/mpg321/"

DEPEND=">=media-sound/mad-0.14.2b
	>=media-libs/libao-0.8.0"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"

MPG123="false"

pkg_setup() {

	# test if mpg123 owns the /usr/bin/mpg123 file. If it does, then do not
	# create a symlink.  If it is already a symlink or does not exist, then
	# we create it
	if [ -f /usr/bin/mpg123 ]
	then
		if [ -L /usr/bin/mpg123 ]
		then
			MPEG123="false"
		else
			MPEG123="true"
		fi
	else
		MPEG123="false"
	fi
}

src_compile() {
	local myconf
	if [ ${MPEG123} = "true" ]
	then
		myconf="--disable-mpg123-symlink"
	else
		myconf="--enable-mpg123-symlink"
	fi
	einfo ${myconf}
	econf ${myconf} || die
	emake || die
}

src_install () {
	einstall || die
}
