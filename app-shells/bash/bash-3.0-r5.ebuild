# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/bash/bash-3.0-r5.ebuild,v 1.3 2004/09/08 14:54:50 vapier Exp $

inherit eutils flag-o-matic gnuconfig

# Official patches
PLEVEL=""

DESCRIPTION="The standard GNU Bourne again shell"
HOMEPAGE="http://www.gnu.org/software/bash/bash.html"
SRC_URI="ftp://ftp.cwru.edu/pub/bash/${P}.tar.gz
	mirror://gnu/bash/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2
	${PLEVEL//x/mirror://gnu/bash/bash-${PV}-patches/bash${PV/\.}-}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~s390 ~sparc"
IUSE="nls build uclibc"

# we link statically with ncurses
DEPEND=">=sys-libs/ncurses-5.2-r2"
RDEPEND=""

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}
	epatch ${DISTDIR}/${P}-gentoo.diff.bz2

	# Remove autoconf dependency
	sed -i -e "/&& autoconf/d" Makefile.in

	# Readline is slow with multibyte locale, bug #19762
	# (No longer applies to bash-3.0)
	#epatch ${FILESDIR}/${P}-multibyte-locale.patch

	# Segfault on empty herestring
	# (Fixed in bash-3.0 with STRLEN instead of strlen)
	#epatch ${FILESDIR}/${P}-empty-herestring.patch

	# Fix broken rbash functionality
	# (Fixed in bash-3.0)
	#epatch ${FILESDIR}/${P}-rbash.patch

	# Fix parallel make, bug #41002.
	# (Added to bash-3.0-gentoo.diff.bz2)
	#epatch ${FILESDIR}/${P}-parallel-build.patch

	# Revert trap behavior for the sake of autoconf-generated configure scripts.
	# The problem here is that bash -c 'trap 0' works, but sh -c 'trap 0'
	# doesn't work because the bash developers are trying to adhere to POSIX in
	# that case.  Since all the configure scripts are #!/bin/sh, this breaks
	# them
	epatch ${FILESDIR}/${P}-posixtrap.patch

	# Patch display.c so that only invisible characters actually on the first
	# line are counted in it.  (This patch doesn't fix everything and Chet says
	# he has a better patch... so watch for it in bash-3.0.1)
	epatch ${FILESDIR}/${P}-invisible.patch

	# Patch readline's bind.c so that /etc/inputrc is read as a last resort
	# following ~/.inputrc.  This is better than putting INPUTRC in
	# the environment because INPUTRC will override even after the
	# user creates a ~/.inputrc
	epatch ${FILESDIR}/${P}-etc-inputrc.patch

	# Chet Ramey (upstream maintainer) provided this patch in
	# http://news.gmane.org/gmane.comp.shells.bash.bugs/cutoff=4115
	# to fix bug 58961 (segfault on local arrays)
	epatch ${FILESDIR}/${P}-local-array.patch

	# Chet Ramey (upstream maintainer) provided this patch to solve
	# bug 60127 (bash 3 breaks array stripping)
	epatch ${FILESDIR}/${P}-array-stripping.patch

	# Enable SSH_SOURCE_BASHRC (#24762)
	echo '#define SSH_SOURCE_BASHRC' >> config-top.h

	# Enable system-wide bashrc (#26952)
	echo '#define SYS_BASHRC "/etc/bash/bashrc"' >> config-top.h

	# Force pgrp synchronization
	# (https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=81653)
	#
	# The session will hang cases where you 'su' (not 'su -') and
	# then run a piped command in emacs.
	# This problem seem to happen due to scheduler changes kernel
	# side - although reproduceble with later 2.4 kernels, it is
	# especially easy with 2.6 kernels.
	echo '#define PGRP_PIPE 1' >> config-bot.h

	gnuconfig_update
}

src_compile() {
	filter-flags -malign-double

	local myconf=

	# Always use the buildin readline, else if we update readline
	# bash gets borked as readline is usually not binary compadible
	# between minor versions.
	#
	# Martin Schlemmer <azarah@gentoo.org> (1 Sep 2002)
	#use readline && myconf="--with-installed-readline"

	# Don't even think about building this statically without
	# reading Bug 7714 first.  If you still build it statically,
	# don't come crying to use with bugs ;).
	#use static && export LDFLAGS="${LDFLAGS} -static"
	use nls || myconf="${myconf} --disable-nls"

	econf \
		--disable-profiling \
		--with-curses \
		--without-gnu-malloc \
		${myconf} || die
	# Make sure we always link statically with ncurses
	sed -i "/^TERMCAP_LIB/s:-lcurses:${ROOT}/usr/lib/libcurses.a:" Makefile || die "sed failed"
	emake || die "make failed"
}

src_install() {
	einstall || die

	dodir /bin
	mv ${D}/usr/bin/bash ${D}/bin
	dosym bash /bin/sh
	dosym bash /bin/rbash

	use uclibc && rm -f ${D}/usr/bin/bashbug ${D}/usr/share/man*/bashbug*

	insinto /etc/bash
	doins ${FILESDIR}/bashrc

	if use build; then
		rm -rf ${D}/usr
	else
		doman doc/*.1
		dodoc README NEWS AUTHORS CHANGES COMPAT Y2K
		dodoc doc/FAQ doc/INTRO

		dosym bash.info.gz /usr/share/info/bashref.info.gz
	fi
}
