# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/jpilot/jpilot-0.99.6-r1.ebuild,v 1.4 2004/02/14 06:28:24 strider Exp $

SYNCMAL="0.72.1"
MALSYNC="2.2.0"
DESCRIPTION="Desktop Organizer Software for the Palm Pilot"
SRC_URI="http://jpilot.org/${P}.tar.gz
	http://www.tomw.org/malsync/malsync_${MALSYNC}.src.tar.gz
	http://jasonday.home.att.net/code/syncmal/jpilot-syncmal-${SYNCMAL}.tar.gz"
HOMEPAGE="http://jpilot.org/"

# In order to use the malsync plugin you'll need to refer to the homepage
# for jpilot-syncmal http://jasonday.home.att.net/code/syncmal/
# And you'll also need an avangto account.

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~alpha"
IUSE="nls gtk2"

RDEPEND="gtk2? ( >=x11-libs/gtk+-2 )
	!gtk2? ( >=x11-libs/gtk+-1.2 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	>=app-pda/pilot-link-0.11.5"

DEPEND="${RDEPEND}
	gtk2? ( dev-util/pkgconfig )
	nls? ( sys-devel/gettext )"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	unpack jpilot-syncmal-${SYNCMAL}.tar.gz
	cd ${S}/jpilot-syncmal-${SYNCMAL}
	unpack malsync_${MALSYNC}.src.tar.gz
}

src_compile() {
	econf $(use_enable gtk2) \
		$(use_enable nls) \
		${myconf} || die "configure failed"

	# make sure we use $CFLAGS
	sed -i "s/-g -O2/${CFLAGS}/" Makefile
	emake || die "make failed"

	# build malsync plugin
	cd ${S}/jpilot-syncmal-${SYNCMAL}
	econf $(use_enable gtk2) \
		${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	# work around for broken Makefile
	dodir /usr/bin

	einstall \
		docdir=${D}/usr/share/doc/${PF} \
		icondir=${D}/usr/share/doc/${PF}/icons \
		desktopdir=${D}/usr/share/applications || die "install failed"

	insinto /usr/lib/jpilot/plugins
	doins jpilot-syncmal-${SYNCMAL}/.libs/libsyncmal.so

	dodoc README TODO UPGRADING ABOUT-NLS BUGS ChangeLog COPYING INSTALL
	doman docs/*.1

	newdoc jpilot-syncmal-${SYNCMAL}/ChangeLog ChangeLog.jpilot-syncmal
	newdoc jpilot-syncmal-${SYNCMAL}/README README.jpilot-syncmal
	dodoc jpilot-syncmal-${SYNCMAL}/malsync/Doc/README_AvantGo
	dodoc jpilot-syncmal-${SYNCMAL}/malsync/Doc/README_malsync
	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins ${S}/jpilotrc.*
}
