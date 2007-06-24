# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/elfsh/elfsh-0.65_rc1.ebuild,v 1.2 2007/06/24 17:48:30 peper Exp $

inherit eutils toolchain-funcs

MY_PV=${PV/_/}
DESCRIPTION="scripting language to modify ELF binaries"
HOMEPAGE="http://elfsh.segfault.net/"
SRC_URI="mirror://gentoo/elfsh-${MY_PV}.tgz"
#http://elfsh.segfault.net/files/elfsh-${MY_PV}-portable.tgz

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="readline"

DEPEND=">=dev-libs/expat-1.95
	readline? ( sys-libs/readline )"

S=${WORKDIR}/${PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's: -O2 : :g' \
		-e "s: -g3 : ${CFLAGS} :" \
		-e "/^LDFLAGS/s:=:=${LDFLAGS} :" \
		$(find -name Makefile) \
		|| die
}

src_compile() {
	local bits
	touch foo.c && $(tc-getCC) -c foo.c -o foo.o || die
	case $(file foo.o) in
		*64-bit*)  bits=64;;
		*32-bit*)  bits=32;;
		*)         die "unknown bits: $(file foo.o)";;
	esac
	# not an autoconf script
	./configure \
		$([[ ${bits} == "64" ]] && echo "--enable-m64") \
		--enable-${bits} \
		$(use_enable readline) \
		|| die
	# emacs does not have to be a requirement.
	emake ETAGS=echo || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
	dodoc README.FIRST doc/AUTHOR doc/CREDITS doc/Changelog doc/*.txt
	doman doc/*.1
}
