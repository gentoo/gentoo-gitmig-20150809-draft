# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jpilot/jpilot-0.99.5.ebuild,v 1.3 2003/06/29 23:17:15 aliz Exp $

SYNCMAL="0.71.2"
MALSYNC="2.1.1"
DESCRIPTION="Desktop Organizer Software for the Palm Pilot"
SRC_URI="http://jpilot.org/${P}.tar.gz
	http://www.tomw.org/malsync/malsync_${MALSYNC}.src.tar.gz
	http://jasonday.home.att.net/code/syncmal/jpilot-syncmal_${SYNCMAL}.tar.gz"
HOMEPAGE="http://jpilot.org/"

# In order to use the malsync plugin you'll need to refer to the homepage
# for jpilot-syncmal http://jasonday.home.att.net/code/syncmal/
# And you'll also need an avangto account. 

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"
IUSE="nls"

DEPEND=">=x11-libs/gtk+-2
	>=dev-libs/pilot-link-0.11.5"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	unpack jpilot-syncmal_${SYNCMAL}.tar.gz
	cd ${S}/jpilot-syncmal_${SYNCMAL}
	unpack malsync_${MALSYNC}.src.tar.gz
}

src_compile() {
	use nls || myconf="--disable-nls"
	use gtk2 && myconf="${myconf} --enable-gtk2" \
			 || myconf="${myconf} --disable-gtk2"
    econf ${myconf}

	# make sure we use $CFLAGS
	mv Makefile Makefile.old
	sed -e "s/-g -O2/${CFLAGS}/" Makefile.old > Makefile
	emake || die

	# build malsync plugin
	cd ${S}/jpilot-syncmal_${SYNCMAL}
	econf ${myconf}
	emake || die
}

src_install() {
	# work around for broken Makefile
	dodir /usr/bin

	einstall

	insinto /usr/lib/jpilot/plugins
	doins jpilot-syncmal_${SYNCMAL}/.libs/libsyncmal.so

	dodoc README TODO UPGRADING ABOUT-NLS BUGS ChangeLog COPYING \
	      INSTALL
	doman docs/*.1

	newdoc jpilot-syncmal_${SYNCMAL}/ChangeLog ChangeLog.jpilot-syncmal
	newdoc jpilot-syncmal_${SYNCMAL}/README README.jpilot-syncmal
	dodoc jpilot-syncmal_${SYNCMAL}/malsync/Doc/README_AvantGo 
	dodoc jpilot-syncmal_${SYNCMAL}/malsync/Doc/README_malsync
}
