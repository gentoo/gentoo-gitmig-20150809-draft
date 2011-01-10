# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/fte/fte-20051115-r2.ebuild,v 1.2 2011/01/10 16:18:31 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Lightweight text-mode editor"
HOMEPAGE="http://fte.sourceforge.net"
SRC_URI="mirror://sourceforge/fte/${P}-src.zip
	mirror://sourceforge/fte/${P}-common.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc -sparc ~x86"
IUSE="gpm slang X"

S="${WORKDIR}/${PN}"

RDEPEND=">=sys-libs/ncurses-5.2
	X? (
		x11-libs/libXdmcp
		x11-libs/libXau
		x11-libs/libX11
		x11-libs/libXpm
	)
	gpm? ( >=sys-libs/gpm-1.20 )"
DEPEND="${RDEPEND}
	slang? ( >=sys-libs/slang-2.1.3 )
	app-arch/unzip"

set_targets() {
	export TARGETS=""
	use slang && TARGETS="${TARGETS} sfte"
	use X && TARGETS="${TARGETS} xfte"

	TARGETS="${TARGETS} vfte"
}

src_prepare() {
	epatch "${FILESDIR}"/fte-gcc34
	epatch "${FILESDIR}"/${PN}-new_keyword.patch
	epatch "${FILESDIR}"/${PN}-slang.patch

	sed /usr/include/linux/keyboard.h -e '/wait.h/d' > src/hacked_keyboard.h

	sed \
		-e "s:<linux/keyboard.h>:\"hacked_keyboard.h\":" \
		-i src/con_linux.cpp || die "sed keyboard"
	sed \
		-e 's:^OPTIMIZE:#&:g' \
		-e '/^LDFLAGS/s:=:+=:g' \
		-e 's:= g++:= $(CXX):g' \
		-i src/fte-unix.mak || die "sed CFLAGS, LDFLAGS, CC"
}

src_configure() {
	set_targets
	sed \
		-e "s:@targets@:${TARGETS}:" \
		-i src/fte-unix.mak || die "sed targets"

	if ! use gpm; then
		sed \
			-e "s:#define USE_GPM://#define USE_GPM:" \
			-i src/con_linux.cpp || die "sed USE_GPM"
		sed \
			-e "s:-lgpm::" \
			-i src/fte-unix.mak || die "sed -lgpm"
	fi
}

src_compile() {
	DEFFLAGS="PREFIX=/usr CONFIGDIR=/usr/share/fte \
		DEFAULT_FTE_CONFIG=../config/main.fte"

	set_targets
	emake CXX=$(tc-getCXX) OPTIMIZE="${CXXFLAGS}" ${DEFFLAGS} TARGETS="${TARGETS}" \
		all || die "emake failed"
}

src_install() {
	local files

	keepdir /etc/fte

	into /usr

	set_targets
	files="${TARGETS} cfte"

	for i in ${files}; do
		dobin src/$i || die "dobin ${i}"
	done

	dobin "${FILESDIR}"/fte || die "dobin fte"

	dodoc Artistic CHANGES BUGS HISTORY README TODO
	dohtml doc/*

	dodir usr/share/fte
	insinto /usr/share/fte
	doins -r config/*

	rm -rf "${D}"/usr/share/fte/CVS
}

pkg_postinst() {
	ebegin "Compiling configuration"
	cd /usr/share/fte || die "missing configuration dir"
	/usr/bin/cfte main.fte /etc/fte/system.fterc
	eend $?
}
