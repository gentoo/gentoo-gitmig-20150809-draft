# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbkeys/bbkeys-0.8.4.ebuild,v 1.6 2002/08/03 16:22:57 cselkirk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Use keyboard shortcuts in the blackbox wm"
HOMEPAGE="http://bbkeys.sourceforge.net"
SRC_URI="http://bbkeys.sourceforge.net/downloads/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/blackbox"

src_compile() {
	./configure		\
		--host=${CHOST}	\
		--prefix=/usr || die "./configure failed"
	emake || die
}

src_install () {
	make 	\
		prefix=${D}/usr	\
		install || die
	rm -rf ${D}/usr/doc
	dodoc AUTHORS BUGS ChangeLog NEWS README
}

#What the hell was this trying to do? Make bbkeys automatically start?
#Well, I had to update this to at least attempt to work with the locations of
#X11R6 binaries. (They used to be in /usr/X11R6/bin, but alas, no more)
#Anyway you slice it though, this fails while blackbox is actually running, and
#I don't it'll work even if it not running. Also if I'm correct and this is what
#it's trying to do, I'd really suggest that you just use .xinitrc in your home
#directories. Add the command before the blackbox command and all is good.
#pkg_postinst() {
#	cd ${ROOT}usr/bin/
#	if [ ! "`grep bbkeys blackbox`" ] ; then
#	sed -e "s/.*blackbox/exec \/usr\/bin\/bbkeys \&\n&/" blackbox | cat > blackbox
#	fi
#}
