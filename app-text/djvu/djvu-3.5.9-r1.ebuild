# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/djvu/djvu-3.5.9-r1.ebuild,v 1.6 2004/03/21 15:11:02 mholzer Exp $

inherit nsplugins

MY_P="${PN}libre-${PV}"
DESCRIPTION="A web-centric format and software platform for distributing documents and images."
HOMEPAGE="http://djvu.sourceforge.net"
SRC_URI="mirror://sourceforge/djvu/${MY_P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE=""
DEPEND=">=x11-libs/qt-3.0.4.20020606-r1
		>=media-libs/jpeg-6b-r2"

S=${WORKDIR}/${MY_P}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	make depend || die
	emake || die
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
	# Again, verify the Makefiles!  We don't want anything falling
	# outside of ${D}.

	# plugin installation
	inst_plugin /usr/lib/netscape/plugins/nsdejavu.so

}

