# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@saintmail.net>, Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/win32codecs/win32codecs-0.18.ebuild,v 1.1 2001/09/24 05:10:20 woodchip Exp $

S=${WORKDIR}
DESCRIPTION="Win32 binary codecs for MPlayer and maybe avifile as well"
SRC_URI="ftp://ftp.mplayerhq.hu/MPlayer/releases/w32codec.zip"
HOMEPAGE="http://www.mplayerhq.hu/"

DEPEND=""

src_install () {
	insinto /usr/lib/win32 ; doins ${S}/*
}
