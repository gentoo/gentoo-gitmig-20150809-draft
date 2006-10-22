# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gnucap/gnucap-20060708.ebuild,v 1.8 2006/10/22 23:48:16 plasmaroo Exp $

MY_PV="${PV:0:4}-${PV:4:2}-${PV:6}"

DESCRIPTION="GNUCap is the GNU Circuit Analysis Package"
SRC_URI="http://geda.seul.org/dist/gnucap-${MY_PV}.tar.gz"
HOMEPAGE="http://www.geda.seul.org/tools/gnucap"

IUSE="doc examples readline"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"

DEPEND="doc? ( virtual/tetex )
	readline? ( sys-libs/readline )"
S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	unpack ${A} || die "Failed to unpack!"
	cd ${S}

	# Don't let gnucap decide whether to use readline
	if ! use readline ; then
		sed -i \
			-e 's:LIBS="-lreadline $LIBS":LIBS="$LIBS":' \
			-e 's:#define HAVE_LIBREADLINE 1:#define HAVE_LIBREADLINE 0:' \
			configure || die "sed failed"
	fi

	# No need to install COPYING and INSTALL
	sed -i \
		-e 's: COPYING INSTALL::' \
		-e 's:COPYING history INSTALL:history:' \
		doc/Makefile.in || die "sed failed"

	if ! use doc ; then
		sed -i \
			-e 's:SUBDIRS = doc examples man:SUBDIRS = doc examples:' \
			Makefile.in || die "sed failed"
	fi

	if ! use examples ; then
		sed -i \
			-e 's:SUBDIRS = doc examples:SUBDIRS = doc:' \
			Makefile.in || die "sed failed"
	fi
}

src_compile() {
	econf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install () {
	make DESTDIR=${D} install || die "Installation failed"
}
