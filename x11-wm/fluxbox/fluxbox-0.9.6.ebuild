# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fluxbox/fluxbox-0.9.6.ebuild,v 1.6 2003/12/20 01:52:38 tseng Exp $

IUSE="gnome kde nls xinerama truetype"

#inherit flag-o-matic eutils

DESCRIPTION="Fluxbox is yet another windowmanager for X. It's based on the Blackbox 0.61.1 code. Fluxbox looks like blackbox and handles styles, colors, window placement and similar thing exactly like blackbox (100% theme/style compability). So what's the difference between fluxbox and blackbox then? The answer is: LOTS! *This is a development release and should not be considered stable.* *This release includes the Blueflux style.*"
SRC_URI="mirror://sourceforge/fluxbox/${P}.tar.gz
	http://koti.mbnet.fi/bionik/blueflux/blueflux_0.1.0.tar.gz"
HOMEPAGE="http://www.fluxbox.org/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ppc ~mips ~sparc ~alpha ~amd64"

DEPEND="virtual/x11
		>=sys-devel/autoconf-2.52"
RDEPEND="x11-misc/commonbox-utils
		x11-themes/commonbox-styles"
PROVIDE="virtual/blackbox"

mydoc="ChangeLog COPYING NEWS"

src_unpack() {

	unpack ${A}
	cd ${S}

	use nls && ( \
		einfo "Redirecting NLS"
		for i in `find ${S} -name 'Makefile.am'`
		do
			sed -i -e 's:$(pkgdatadir)/nls:/usr/share/locale:' ${i}
		done
	)

	sed -i -e 's:bsetroot.1::' ${S}/doc/Makefile.am
	sed -i -e 's:bsetroot::' ${S}/util/Makefile.*
}


src_compile() {

	econf \
		`use_enable nls` \
		`use_enable kde` \
		`use_enable gnome` \
		`use_enable xinerama` \
		`use_enable truetype xft` \
		--sysconfdir=/etc/X11/${PN} \
		--datadir=/usr/share/commonbox \
		${myconf} || die

	sed -i -e 's:\$(datadir)/fluxbox:/usr/share/commonbox:' ${S}/Makefile
	sed -i -e 's:\$(datadir)/fluxbox:/usr/share/commonbox:' ${S}/data/Makefile

	emake \
		pkgdatadir=/usr/share/commonbox || die

	cd data make \
		pkgdatadir=/usr/share/commonbox init
}

src_install() {

	dodir /usr/share/commonbox/${PN}
	dodir /usr/share/commonbox/styles
	make DESTDIR=${D} install || die
	dodoc README* AUTHORS TODO* ${mydoc}
	rmdir ${D}/usr/share/${PN}
	dodir /etc/X11/Sessions
	echo "/usr/bin/${PN}" > ${D}/etc/X11/Sessions/${PN}
	fperms a+x /etc/X11/Sessions/${PN}

	cd data
	insinto /usr/share/commonbox
	doins init keys
	insinto /usr/share/commonbox/styles
	doins ${D}/usr/share/commonbox/fluxbox/styles/Meta
	rm -rf ${D}/usr/share/commonbox/fluxbox

	# blueflux style
	insinto /usr/share/commonbox/pixmaps
	doins ${WORKDIR}/pixmaps/*
	# fix some paths and change b->B at the same time
	sed -e 's:\.fluxbox:/usr/share/commonbox:' ${WORKDIR}/styles/blueflux \
		> ${WORKDIR}/styles/Blueflux
	insinto /usr/share/commonbox/styles
	doins ${WORKDIR}/styles/Blueflux
}
