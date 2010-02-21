# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/biew/biew-6.1.0.ebuild,v 1.1 2010/02/21 09:46:24 patrick Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="A portable viewer of binary files, hexadecimal and disassembler modes."
HOMEPAGE="http://biew.sourceforge.net"
SRC_URI="mirror://sourceforge/project/beye/biew/${PV}/${PN}-${PV//./}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gpm"

DEPEND="gpm? ( sys-libs/gpm )"

RDEPEND="gpm? (
		        x86? ( sys-libs/gpm )
		        amd64? ( app-emulation/emul-linux-x86-baselibs )
	     )"
# biew build only compiles 32-bit binary on amd64, and 32-bit libgpm is in
# app-emulation/emul-linux-x86-baselibs

S=${WORKDIR}/${PN}-${PV//./}

src_compile() {
	local enable_gpm

	if use gpm ; then
		enable_gpm=yes
	else
		enable_gpm=no
	fi
	export _gpm=${enable_gpm}

	append-flags -D_GNU_SOURCE

	econf --cc="$(tc-getCC)" --ld="$(tc-getCC)" \
		--ar="$(tc-getAR) -rcu" --ranlib="$(tc-getRANLIB)" \
		--enable-debug
	emake HOST_CFLAGS="${CFLAGS}" HOST_LDFLAGS="${LDFLAGS}" \
		|| die "make failed"
	for i in doc/*.ru doc/file_id.diz doc/biew_ru.txt doc/biew_en.txt
	do
		if iconv -f cp866 -t utf-8 "$i" > "$i.conv"
		then
			mv "$i.conv" "$i"
		fi
	done
}

src_install() {
	make install DESTDIR="${D}"
	doman doc/biew.1
	dodoc doc/*.txt doc/*.en doc/*.ru doc/file_id.diz
}
