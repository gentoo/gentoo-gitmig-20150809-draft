# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gpm/gpm-1.20.0-r6.ebuild,v 1.6 2003/06/22 05:10:31 seemant Exp $

IUSE=""

inherit eutils

S="${WORKDIR}/${P}"
DESCRIPTION="Console-based mouse driver"
SRC_URI="ftp://arcana.linux.it/pub/gpm/gpm-1.20.0.tar.bz2
	http://www.ibiblio.org/gentoo/distfiles/gpm-1.20.1-patch.tar.bz2
	http://www.ibiblio.org/gentoo/distfiles/gpm-1.20.1-log-fillup.patch.tar.bz2"
HOMEPAGE="ftp://arcana.linux.it/pub/gpm/"

DEPEND=">=sys-libs/ncurses-5.2
	sys-devel/autoconf"
	
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa arm"

src_unpack() {
	unpack ${A}

	# This little hack turns off EMACS byte compilation.  We really
	# don't want this thing auto-detecting emacs.
	cd ${S}; epatch ${WORKDIR}/gpm.patch
	cd ${S}; epatch ${WORKDIR}/gpm-log-fillup.patch

	# Add missing 'mkinstalldirs' script
	cp -f /usr/share/automake/mkinstalldirs ${S}
}

src_compile() {
	econf --sysconfdir=/etc/gpm || die

	# Do not create gpmdoc.ps, as it cause build to fail with our version
	# of tetex (it is already there, so this will only create missing
	# manpages)
	cp doc/Makefile doc/Makefile.orig
	sed -e 's:all\: $(srcdir)/gpmdoc.ps:all\::' \
		doc/Makefile.orig > doc/Makefile

	MAKEOPTS="-j1" emake || die
}

src_install() {
	einstall
	
	chmod 755 ${D}/usr/lib/*
	# Fix missing /usr/lib/libgpm.so.1
	preplib
	
	dodoc BUGS COPYING ChangeLog Changes MANIFEST README TODO
	dodoc doc/Announce doc/FAQ doc/README*
	doinfo doc/gpm.info

	insinto /etc/gpm
	doins conf/gpm-*.conf

	exeinto /etc/init.d
	newexe ${FILESDIR}/gpm.rc6 gpm
	insinto /etc/conf.d
	newins ${FILESDIR}/gpm.conf.d gpm
}

