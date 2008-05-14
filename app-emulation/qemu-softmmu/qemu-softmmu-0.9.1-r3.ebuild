# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu-softmmu/qemu-softmmu-0.9.1-r3.ebuild,v 1.3 2008/05/14 19:40:21 lu_zero Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Multi-platform & multi-targets cpu emulator and dynamic translator"
HOMEPAGE="http://fabrice.bellard.free.fr/qemu/"
SRC_URI="${HOMEPAGE}${P/-softmmu/}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="-alpha ~amd64 ppc -sparc x86"
IUSE="sdl kqemu gnutls alsa"
RESTRICT="binchecks test"

DEPEND="virtual/libc
	sys-libs/zlib
	sdl? ( media-libs/libsdl )
	!<=app-emulation/qemu-0.7.0
	kqemu? ( >=app-emulation/kqemu-1.3.0_pre10 )
	gnutls? (
		dev-util/pkgconfig
		net-libs/gnutls
	)
	app-text/texi2html"
RDEPEND="sys-libs/zlib
	sdl? ( media-libs/libsdl )
	gnutls? ( net-libs/gnutls )
	alsa? ( media-libs/alsa-lib )"

S=${WORKDIR}/${P/-softmmu/}

pkg_setup() {
	if [ "$(gcc-major-version)" == "4" ]; then
		eerror "qemu requires gcc-3 in order to build and work correctly"
		eerror "please compile it switching to gcc-3."
		eerror "We are aware that qemu can guess a gcc-3 but this feature"
		eerror "could be harmful."
		die "gcc 4 cannot build qemu"
	fi
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-CVE-2008-0928.patch" #212351
	epatch "${FILESDIR}/${P}-CVE-2008-2004.patch" #221943
	# Alter target makefiles to accept CFLAGS set via flag-o.
	sed -i 's/^\(C\|OP_C\|HELPER_C\)FLAGS=/\1FLAGS+=/' \
		Makefile Makefile.target tests/Makefile
	# Ensure mprotect restrictions are relaxed for emulator binaries
	[[ -x /sbin/paxctl ]] && \
		sed -i 's/^VL_LDFLAGS=$/VL_LDFLAGS=-Wl,-z,execheap/' \
			Makefile.target
	# Prevent install of kernel module by qemu's makefile
	sed -i 's/\(.\/install.sh\)/#\1/' Makefile
	# avoid strip
	sed -i 's:$(INSTALL) -m 755 -s:$(INSTALL) -m 755:' Makefile Makefile.target
}

src_compile() {
	if use x86 ; then
		# Force -march=pentium-mmx or lower. Fixes bug #212351.
		local march
		march=$(echo "${CFLAGS}" | sed 's:^.*-march=\([[:alnum:]-]\+\)\([[:blank:]].*\)\?$:\1:p;d')
		case ${march} in
			i386|i486|i586|pentium) ;;
			*) # Either march is not enough low or not exists at all
			case ${CHOST} in
				i486-*-*)	march=i486 ;;
				i586-*-*)	march=i586 ;;
				*)			march=pentium-mmx ;;
			esac ;;
		esac
		#Let the application set its cflags
		unset CFLAGS
		append-flags -march=${march}
	else
		#Let the application set its cflags
		unset CFLAGS
	fi

	# Switch off hardened tech
	filter-flags -fpie -fstack-protector

	myconf="--disable-gcc-check"
	if use alsa; then
		myconf="$myconf --enable-alsa"
	fi
	if ! use gnutls; then
		myconf="$myconf --disable-vnc-tls"
	fi
	if ! use kqemu; then
		myconf="$myconf --disable-kqemu"
	fi
	if ! use sdl ; then
		myconf="$myconf --disable-sdl --disable-gfx-check"
	fi
	# econf does not work
	./configure \
		--prefix=/usr \
		--enable-adlib \
		--cc=$(tc-getCC) \
		--host-cc=$(tc-getCC) \
		--disable-linux-user \
		--enable-system \
		${myconf} \
		|| die "could not configure"

	emake OS_CFLAGS="${CFLAGS}" || die "make failed"
}

src_install() {
	emake install \
		prefix="${D}/usr" \
		bindir="${D}/usr/bin" \
		datadir="${D}/usr/share/qemu" \
		docdir="${D}/usr/share/doc/${P}" \
		mandir="${D}/usr/share/man" || die

	chmod -x "${D}/usr/share/man/*/*"
}

pkg_postinst() {
	einfo "You will need the Universal TUN/TAP driver compiled into"
	einfo "kernel or as a module to use the virtual network device."
}
