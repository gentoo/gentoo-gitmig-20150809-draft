# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ruby/ruby-1.8.2_pre2.ebuild,v 1.1 2004/07/31 19:47:36 usata Exp $

ONIGURUMA="onigd2_3_1"
MY_P=${P/_pre/-preview}

inherit flag-o-matic alternatives eutils gnuconfig

DESCRIPTION="An object-oriented scripting language"
HOMEPAGE="http://www.ruby-lang.org/"
SRC_URI="mirror://ruby/${PV%.*}/${MY_P}.tar.gz"
SRC_URI="${SRC_URI}
	cjk? ( http://www.geocities.jp/kosako1/oniguruma/archive/${ONIGURUMA}.tar.gz )"

LICENSE="Ruby"
SLOT="1.8"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 -ia64 ~s390 macos"
IUSE="socks5 tcltk cjk"

RDEPEND="virtual/libc
	>=sys-libs/gdbm-1.8.0
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	socks5? ( >=net-misc/dante-1.1.13 )
	tcltk? ( dev-lang/tk )
	>=dev-ruby/ruby-config-0.3
	!=dev-lang/ruby-cvs-1.8*"
DEPEND="sys-devel/autoconf
	sys-apps/findutils
	${RDEPEND}"
PROVIDE="virtual/ruby"

S=${WORKDIR}/${P%_*}

src_unpack() {
	unpack ${A}

	if use cjk ; then
		einfo "Applying ${ONIGURUMA}"
		pushd ${WORKDIR}/oniguruma
		econf --with-rubydir=${S} || die "econf failed"
		make ${SLOT/./}
		popd
	fi

	# Enable build on alpha EV67
	if use alpha ; then
		gnuconfig_update || die "gnuconfig_update failed"
	fi
}

src_compile() {
	filter-flags -fomit-frame-pointer

	# Socks support via dante
	if use socks5; then
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

	econf \
		--program-suffix=${SLOT/./} \
		--enable-shared \
		`use_enable socks5 socks` \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	if use macos ; then
		dosym /usr/lib/libruby${SLOT/./}.${PV%_*}.dylib /usr/lib/libruby.${PV%.*}.dylib
		dosym /usr/lib/libruby${SLOT/./}.${PV%_*}.dylib /usr/lib/libruby.${PV%_*}.dylib
	else
		dosym /usr/lib/libruby${SLOT/./}.so.${PV%_*} /usr/lib/libruby.so.${PV%.*}
		dosym /usr/lib/libruby${SLOT/./}.so.${PV%_*} /usr/lib/libruby.so.${PV%_*}
	fi

	dodoc COPYING* ChangeLog MANIFEST README* ToDo
}

pkg_postinst() {
	if ! use macos ; then
		ewarn
		ewarn "Warning: Vim won't work if you've just updated ruby from"
		ewarn "1.6.x to 1.8.x due to the library version change."
		ewarn "In that case, you will need to remerge vim."
		ewarn

		if [ ! -n "$(readlink ${ROOT}usr/bin/ruby)" ] ; then
			${ROOT}usr/sbin/ruby-config ruby${SLOT/./}
		fi
		einfo
		einfo "You can change the default ruby interpreter by ${ROOT}usr/sbin/ruby-config"
		einfo
	fi
}

pkg_postrm() {
	if ! use macos ; then
		if [ ! -n "$(readlink ${ROOT}usr/bin/ruby)" ] ; then
			${ROOT}usr/sbin/ruby-config ruby${SLOT/./}
		fi
	fi
}
