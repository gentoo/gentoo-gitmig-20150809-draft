#!/usr/bin/ebuild
# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ed/ed-0.2.ebuild,v 1.1 2000/09/24 04:48:39 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Your basic line editor"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/ed/${A}"

src_compile() {                           
	try ./configure --prefix=/ --host=${CHOST}
	try make
}

src_install() {                               
	try make prefix=${D}/ install
}

