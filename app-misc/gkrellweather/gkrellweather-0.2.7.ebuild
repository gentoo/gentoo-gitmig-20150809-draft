# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <blutgens@gentoo.org>
# $Header: /home/cvsroot/gentoo-x86/app-misc/gkrellm-volume-0.8.ebuild,v 1.0 
# 26 Apr 2001 21:30 CST blutgens Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Gkrellm Plugin that monitors a METAR station and displays weather
info"
SRC_URI="http://www.cse.unsw.edu.au/~flam/repository/c/gkrellm/${A}"
HOMEPAGE="http://www.cse.unsw.edu.au/~flam/programs/gkrellweather.html"

DEPEND=">=app-admin/gkrellm-1.0.6
	>=net-misc/wget-1.5.3"

src_compile() {

    try make

}

src_install () {

    insinto /usr/share/gkrellm/plugins
    doins gkrellweather.so
    insinto /usr/bin
    doins GrabWeather 
    dodoc README ChangeLog COPYING
}

