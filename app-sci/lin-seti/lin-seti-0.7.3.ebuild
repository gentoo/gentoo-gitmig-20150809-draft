# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:

DESCRIPTION="A Seti@Home cache manager, cache-compatible with Seti Driver. Can be run as system daemon."
HOMEPAGE="http://lin-seti.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc ~alpha"
IUSE=""
DEPEND="app-sci/setiathome"

src_compile() {
	emake || die
}

src_install() {
	
  mkdir -m 755 ${D}usr
	mkdir -m 755 ${D}usr/bin
	mkdir -m 755 ${D}opt
	mkdir -m 755 ${D}etc
	mkdir -m 755 ${D}etc/init.d
	make \
	  PREFIX=${D} \
	  install || die

	# Let's see if this file already exists: if so we will not install it
	if [ -a "/opt/setiathome/cache/1/user_info.sah" ]; then rm ${D}opt/setiathome/cache/1/user_info.sah; fi
  # Otherwise the ebuild will overwrite this file!
	# And THAT is bad: if the client runs in daemon mode, 
	# when switching to that dir it will wait forever for someone to give it
	# some info (which would be impossible, being detached from all terminals)!
}

pkg_postinst () {

	einfo "NOTICE: If you use SETI Driver for Windows"
	einfo "to share the cache make sure it is"
	einfo "version 1.6.4.0 or higher!"
	sleep 5		
}
