# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ruby/ruby-1.6.8-r12.ebuild,v 1.1 2004/11/04 16:25:59 usata Exp $

IUSE="cjk"

ONIGURUMA="onigd2_3_3"
SNAP_DATE="2004.07.28"
MY_P="${P}-${SNAP_DATE}"
S="${WORKDIR}/${MY_P}"

inherit flag-o-matic alternatives eutils

DESCRIPTION="An object-oriented scripting language"
HOMEPAGE="http://www.ruby-lang.org/"
#SRC_URI="mirror://ruby/${PV%.*}/${P/_pre/-preview}.tar.gz"
SRC_URI="mirror://ruby/snapshots/${MY_P}.tar.gz
	cjk? ( http://www.geocities.jp/kosako1/oniguruma/archive/${ONIGURUMA}.tar.gz )"

LICENSE="Ruby"
SLOT="1.6"
KEYWORDS="x86 alpha ppc ~sparc ~hppa ~amd64 -ia64 ~mips"

DEPEND="virtual/libc
	>=sys-libs/gdbm-1.8.0
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	>=dev-ruby/ruby-config-0.3"
PROVIDE="virtual/ruby"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-${SNAP_DATE//./}-20041024.diff
	use amd64 && epatch ${FILESDIR}/${P}-fix-x86_64.patch

	if use cjk ; then
		einfo "Applying ${ONIGURUMA}"
		cd ${WORKDIR}/oniguruma
		if use ppc || use ppc64 || use alpha ; then
			epatch ${FILESDIR}/oniguruma-2.3.1-fix-ppc.patch
		fi
		econf --with-rubydir=${S} || die "econf failed"
		make ${SLOT/./}
	fi
}

src_compile() {
	filter-flags -fomit-frame-pointer
	econf --program-suffix=${SLOT/./} --enable-shared || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dosym /usr/lib/libruby${SLOT/./}.so.${PV} /usr/lib/libruby.so.${PV%.*}
	dosym /usr/lib/libruby${SLOT/./}.so.${PV} /usr/lib/libruby.so.${PV}

	dodoc COPYING* ChangeLog MANIFEST README* ToDo
}

pkg_postinst() {

	if [ ! -n "$(readlink ${ROOT}usr/bin/ruby)" ] ; then
		${ROOT}usr/sbin/ruby-config ruby${SLOT/./}
	fi
	einfo
	einfo "You can change the default ruby interpreter by ${ROOT}usr/sbin/ruby-config"
	einfo
}

pkg_postrm() {

	if [ ! -n "$(readlink ${ROOT}usr/bin/ruby)" ] ; then
		${ROOT}usr/sbin/ruby-config ruby${SLOT/./}
	fi
}
