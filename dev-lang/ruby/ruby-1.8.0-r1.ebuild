# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ruby/ruby-1.8.0-r1.ebuild,v 1.7 2004/03/25 08:35:01 kumba Exp $

inherit flag-o-matic alternatives eutils gnuconfig
filter-flags -fomit-frame-pointer

S=${WORKDIR}/${P%_pre*}
DESCRIPTION="An object-oriented scripting language"
HOMEPAGE="http://www.ruby-lang.org/"
SRC_URI="mirror://ruby/${PV%.*}/${P/_pre/-preview}.tar.gz"

LICENSE="Ruby"
SLOT="1.8"
KEYWORDS="alpha hppa ia64 mips sparc x86"
IUSE="socks5 tcltk ruby16"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gdbm-1.8.0
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	socks5? ( >=net-misc/dante-1.1.13 )
	tcltk?  ( dev-lang/tk )
	sys-apps/findutils"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}

	# Enable build on alpha EV67
	if use alpha; then
		gnuconfig_update || die "gnuconfig_update failed"
	fi
}

src_compile() {
	# Socks support via dante
	if [ ! -n "`use socks5`" ] ; then
		# Socks support can't be disabled as long as SOCKS_SERVER is
		# set and socks library is present, so need to unset
		# SOCKS_SERVER in that case.
		unset SOCKS_SERVER
	fi

	# Increase GC_MALLOC_LIMIT if set (default is 8000000)
	if [ -n "${RUBY_GC_MALLOC_LIMIT}" ] ; then
		CFLAGS="${CFLAGS} -DGC_MALLOC_LIMIT=${RUBY_GC_MALLOC_LIMIT}"
		export CFLAGS
	fi

	econf --program-suffix=18 --enable-shared \
		`use_enable socks5 socks` \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dosym /usr/lib/libruby18.so.${PV} /usr/lib/libruby.so.${PV%.*}
	dosym /usr/lib/libruby18.so.${PV} /usr/lib/libruby.so.${PV}

	dodoc COPYING* ChangeLog MANIFEST README* ToDo
}

ruby_alternatives() {
	if [ -n "`use ruby16`" ] ; then
		alternatives_makesym /usr/bin/ruby /usr/bin/ruby{16,18}
		alternatives_makesym /usr/bin/irb /usr/bin/irb{16,18}
		alternatives_makesym /usr/lib/libruby.so \
			/usr/lib/libruby{16,18}.so
		alternatives_makesym /usr/share/man/man1/ruby.1.gz \
			/usr/share/man/man1/ruby{16,18}.1.gz
	else
		alternatives_makesym /usr/bin/ruby /usr/bin/ruby{18,16}
		alternatives_makesym /usr/bin/irb /usr/bin/irb{18,16}
		alternatives_makesym /usr/lib/libruby.so \
			/usr/lib/libruby{18,16}.so
		alternatives_makesym /usr/share/man/man1/ruby.1.gz \
			/usr/share/man/man1/ruby{18,16}.1.gz
	fi
	alternatives_auto_makesym /usr/bin/erb /usr/bin/erb?*
}

pkg_postinst() {
	ruby_alternatives
	ewarn
	ewarn "Warning: Vim won't work if you've just updated ruby from"
	ewarn "1.6.8 to 1.8.0 due to the library version change."
	ewarn "In that case, you will need to remerge vim."
	ewarn
}

pkg_postrm() {
	ruby_alternatives
}
