# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/bash/bash-3.0-r1.ebuild,v 1.2 2004/07/29 02:57:05 ciaranm Exp $

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

DEPEND=">=sys-libs/ncurses-5.2-r2"

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

	make || die
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
