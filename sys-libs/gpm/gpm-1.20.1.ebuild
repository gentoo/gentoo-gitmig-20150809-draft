# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gpm/gpm-1.20.1.ebuild,v 1.21 2004/10/31 17:30:29 tgall Exp $

# Please use this variable to keep patch names sane for our patches!
PATCH_VER="1.0"

inherit eutils

DESCRIPTION="Console-based mouse driver"
HOMEPAGE="ftp://arcana.linux.it/pub/gpm/"
# Future patch's for gpm should keep this format.  This should help others
# maintain the ebuild and keep patch's simple and and easy to read.
SRC_PATH="ftp://arcana.linux.it/pub/gpm/${P}.tar.bz2"
GPM_PATCHES="mirror://gentoo/${P}-patches-${PATCH_VER}.tar.bz2"
SRC_URI="${SRC_PATH}
	${GPM_PATCHES}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE="selinux"

DEPEND=">=sys-libs/ncurses-5.2
	sys-devel/autoconf"
RDEPEND="selinux? ( sec-policy/selinux-gpm )"

PATCHDIR=${WORKDIR}/patches

src_unpack() {
	unpack ${A}
	unpack ${P}-patches-${PATCH_VER}.tar.bz2

	# This little hack turns off EMACS byte compilation.  We really
	# don't want this thing auto-detecting emacs.
	cd ${S}; epatch ${WORKDIR}/patches

	# Add missing 'mkinstalldirs' script
	cp -f /usr/share/automake/mkinstalldirs ${S}

	use ppc64 && epatch ${FILESDIR}/gpm-linux26-headers.patch
}

src_compile() {
	econf --sysconfdir=/etc/gpm || die

	# Do not create gpmdoc.ps, as it cause build to fail with our version
	# of tetex (it is already there, so this will only create missing
	# manpages)
	cp doc/Makefile doc/Makefile.orig
	sed -e 's:all\: $(srcdir)/gpmdoc.ps:all\::' \
		doc/Makefile.orig > doc/Makefile

	emake -j1 || die
}

src_install() {
	einstall

	chmod 755 ${D}/usr/$(get_libdir)/*
	# Fix missing /usr/$(get_libdir)/libgpm.so.1
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
