# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ruby-cvs/ruby-cvs-1.9.0.ebuild,v 1.1 2004/01/25 12:10:15 usata Exp $

IUSE="socks5 tcltk"

inherit flag-o-matic cvs
filter-flags -fomit-frame-pointer

DESCRIPTION="An object-oriented scripting language"
HOMEPAGE="http://www.ruby-lang.org/"
SRC_URI=""

LICENSE="Ruby"
SLOT="1.9"
KEYWORDS="~alpha ~arm ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gdbm-1.8.0
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	dev-util/gperf
	socks5? ( >=net-misc/dante-1.1.13 )
	tcltk?  ( dev-lang/tk )
	sys-apps/findutils"
PROVIDE="dev-lang/ruby-${PV}"

ECVS_SERVER="cvs.ruby-lang.org:/src"
ECVS_MODULE="ruby"
ECVS_AUTH="pserver"
ECVS_PASS="anonymous"

S=${WORKDIR}/${ECVS_MODULE}

src_compile() {

	local ruby_version=`gawk '$2=="RUBY_VERSION" {print $3}' version.h | tr -d \"`
	if [ "${PV}" != "${ruby_version}" ]; then
		die "version mismatch"
	fi

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

	autoconf || die "autoconf failed"

	# disable install-doc because of yaml/parser
	econf --program-suffix=${SLOT/./} --enable-shared \
		`use_enable socks5 socks` \
		--disable-install-doc \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	#export RUBY=${D}/usr/bin/ruby19
	export LD_LIBRARY_PATH=${D}/usr/lib RUBYLIB=${D}/usr/lib/ruby/1.9
	einstall DESTDIR=${D} || die "einstall failed"

	dosym /usr/lib/libruby${SLOT/./}.so.${PV} /usr/lib/libruby.so.${PV%.*}
	dosym /usr/lib/libruby${SLOT/./}.so.${PV} /usr/lib/libruby.so.${PV}

	dodoc COPYING* ChangeLog MANIFEST README* ToDo
}
