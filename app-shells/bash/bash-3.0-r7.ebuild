# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/bash/bash-3.0-r7.ebuild,v 1.2 2004/11/12 14:36:48 vapier Exp $

inherit eutils flag-o-matic gnuconfig gcc

# Official patchlevel
# See ftp://ftp.cwru.edu/pub/bash/bash-3.0-patches/
PLEVEL=13

DESCRIPTION="The standard GNU Bourne again shell"
HOMEPAGE="http://cnswww.cns.cwru.edu/~chet/bash/bashtop.html"
# Hit the GNU mirrors before hitting Chet's site
SRC_URI="mirror://gnu/bash/${P}.tar.gz
	ftp://ftp.cwru.edu/pub/bash/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2
	$(for ((i=1; i<=PLEVEL; i++)); do
		printf 'ftp://ftp.cwru.edu/pub/bash/bash-%s-patches/bash%s-%03d\n' \
			${PV} ${PV/\.} ${i}
		printf 'mirror://gnu/bash/bash-%s-patches/bash%s-%03d\n' \
			${PV} ${PV/\.} ${i}
	done)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="nls build uclibc"

# we link statically with ncurses
DEPEND=">=sys-libs/ncurses-5.2-r2"
RDEPEND=""

src_unpack() {
	local i

	unpack ${P}.tar.gz

	cd ${S}
	epatch ${DISTDIR}/${P}-gentoo.diff.bz2

	# Remove autoconf dependency
	sed -i -e "/&& autoconf/d" Makefile.in

	# Include official patches
	for ((i=1; i<=PLEVEL; i++)); do
		epatch ${DISTDIR}/${PN}${PV/\.}-$(printf '%03d' ${i})
	done

	# This is another "official" patch that hasn't gotten on the ftp site yet
	epatch ${FILESDIR}/bash30-014

	# Patch readline's bind.c so that /etc/inputrc is read as a last resort
	# following ~/.inputrc.  This is better than putting INPUTRC in
	# the environment because INPUTRC will override even after the
	# user creates a ~/.inputrc
	epatch ${FILESDIR}/${P}-etc-inputrc.patch

	# Fix using bash with post-20040808 glibc ebuilds (from fedora)
	epatch ${FILESDIR}/${P}-jobs.patch

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

	sed -i 's:-lcurses:-lncurses:' configure || die "sed configure"
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

	echo 'int main(){}' > ${T}/term-test.c
	if ! $(gcc-getCC) -static -lncurses ${T}/term-test.c 2> /dev/null ; then
		export bash_cv_termcap_lib=gnutermcap
	else
		export bash_cv_termcap_lib=libcurses
		myconf="${myconf} --with-ncurses"
	fi

	econf \
		--disable-profiling \
		--without-gnu-malloc \
		${myconf} || die
	# Make sure we always link statically with ncurses
	sed -i "/^TERMCAP_LIB/s:-lncurses:-Wl,-Bstatic -lncurses -Wl,-Bdynamic:" Makefile || die "sed failed"
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
