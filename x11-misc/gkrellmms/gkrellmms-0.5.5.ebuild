# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens
# $Header: /home/cvsroot/gentoo-x86/media-sound/gkrellmms-0.5.5.ebuild
# 26 Apr 2001 21:31 CST blutgens Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${PN}
DESCRIPTION="A sweet plugin to controll xmms from gkrellm"
SRC_URI="http://gkrellm.luon.net/files/${A}"
HOMEPAGE="http://gkrellm.luon.net/gkrellm/Plugins.html"

DEPEND=">=app-admin/gkrellm-1.0.6
        >=media-sound/xmms-1.2.4"

src_compile() {

    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc README ChangeLog FAQ Themes
}

