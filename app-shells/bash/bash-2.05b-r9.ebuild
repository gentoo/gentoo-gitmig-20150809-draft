# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/bash/bash-2.05b-r9.ebuild,v 1.1 2003/12/27 21:36:59 azarah Exp $

inherit eutils flag-o-matic gnuconfig

# Official patches
PLEVEL="x002 x003 x004 x005 x006 x007"

DESCRIPTION="The standard GNU Bourne again shell"
SRC_URI="mirror://gnu/bash/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2
	${PLEVEL//x/mirror://gnu/bash/bash-${PV}-patches/bash${PV/\.}-}"
HOMEPAGE="http://www.gnu.org/software/bash/bash.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha ~ppc ~sparc ~ia64 ~mips ~ppc64"
IUSE="nls build"

DEPEND=">=sys-libs/ncurses-5.2-r2"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}
	epatch ${DISTDIR}/${P}-gentoo.diff.bz2

	for x in ${PLEVEL//x}
	do
		epatch ${DISTDIR}/${PN}${PV/\.}-${x}
	done

	# Remove autoconf dependency
	sed -i -e "/&& autoconf/d" Makefile.in

	# Readline is slow with multibyte locale, bug #19762
	epatch ${FILESDIR}/${P}-multibyte-locale.patch
	# Segfault on empty herestring
	epatch ${FILESDIR}/${P}-empty-herestring.patch
	# fix broken rbash functionality
	epatch ${FILESDIR}/${P}-rbash.patch

	# Enable SSH_SOURCE_BASHRC (#24762)
	sed -e 's:^.*\(#define SSH_SOURCE_BASHRC\).*$:\1:' \
		-i config-top.h

	# Force pgrp synchronization
	# (https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=81653)
	#
	# The session will hang cases where you 'su' (not 'su -') and
	# then run a piped command in emacs.
	# This problem seem to happen due to scheduler changes kernel
	# side - although reproduceble with later 2.4 kernels, it is
	# especially easy with 2.6 kernels.
	echo '#define PGRP_PIPE 1' >> config-bot.h
}

src_compile() {

	# If running mips64, we need updated configure data
	use mips && gnuconfig_update

	filter-flags -malign-double

	local myconf=

	# Always use the buildin readline, else if we update readline
	# bash gets borked as readline is usually not binary compadible
	# between minor versions.
	#
	# Martin Schlemmer <azarah@gentoo.org> (1 Sep 2002)
	#use readline && myconf="--with-installed-readline"
	#use static && export LDFLAGS="${LDFLAGS} -static"
	use nls || myconf="${myconf} --disable-nls"

	econf \
		--disable-profiling \
		--with-curses \
		--without-gnu-malloc \
		${myconf} || die

	make || die
}

src_install() {
	einstall || die

	dodir /bin
	mv ${D}/usr/bin/bash ${D}/bin
	dosym bash /bin/sh
	dosym bash /bin/rbash

	use build \
		&& rm -rf ${D}/usr \
		|| ( \
			doman doc/*.1
			dodoc README NEWS AUTHORS CHANGES COMPAT COPYING Y2K
			dodoc doc/FAQ doc/INTRO

			ebegin "creating info symlink"
			dosym bash.info.gz /usr/share/info/bashref.info.gz
			eend $?
	)
}
