# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/emacs/emacs-18.59-r6.ebuild,v 1.6 2009/11/25 11:26:34 maekke Exp $

EAPI=2

inherit eutils toolchain-funcs flag-o-matic multilib

DESCRIPTION="The extensible self-documenting text editor"
HOMEPAGE="http://www.gnu.org/software/emacs/"
SRC_URI="mirror://gnu/old-gnu/emacs/${P}.tar.gz
	ftp://ftp.splode.com/pub/users/friedman/emacs/${P}-linux22x-elf-glibc21.diff.gz
	mirror://gentoo/${P}-patches-4.tar.bz2"

LICENSE="GPL-1 GPL-2 BSD as-is"
SLOT="18"
KEYWORDS="amd64 x86"
IUSE="X"

RDEPEND="sys-libs/ncurses
	>=app-admin/eselect-emacs-1.2
	X? ( x11-libs/libX11[-xcb] )
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		X? ( app-emulation/emul-linux-x86-xlibs )
	)"
DEPEND="${RDEPEND}"

MY_BASEDIR="/usr/share/emacs/${PV}"
MY_LOCKDIR="/var/lib/emacs/lock"

src_prepare() {
	epatch "${WORKDIR}/${P}-linux22x-elf-glibc21.diff"
	EPATCH_SUFFIX=patch epatch
}

src_configure() {
	# autoconf? What's autoconf? We are living in 1992. ;-)
	local arch
	case ${ARCH} in
		amd64) arch=intel386; multilib_toolchain_setup x86 ;;
		x86)   arch=intel386 ;;
		*)	   die "Architecture ${arch} not supported" ;;
	esac
	local cmd="s/\"s-.*\.h\"/\"s-linux.h\"/;s/\"m-.*\.h\"/\"m-${arch}.h\"/"
	use X && cmd="${cmd};s/.*\(#define HAVE_X_WINDOWS\).*/\1/"
	sed -e "${cmd}" src/config.h-dist >src/config.h

	cat <<-END >src/paths.h
		#define PATH_LOADSEARCH "${MY_BASEDIR}/lisp"
		#define PATH_EXEC "${MY_BASEDIR}/etc"
		#define PATH_LOCK "${MY_LOCKDIR}/"
		#define PATH_SUPERLOCK "${MY_LOCKDIR}/!!!SuperLock!!!"
	END

	sed -i -e "s:/usr/lib/\([^ ]*\).o:/usr/$(get_libdir)/\1.o:g" \
		src/s-linux.h || die

	# -O3 and -finline-functions cause segmentation faults at run time.
	filter-flags -finline-functions
	replace-flags -O[3-9] -O2
	strip-flags
}

src_compile() {
	# Do not use the sandbox, or the dumped Emacs will be twice as large
	SANDBOX_ON=0
	emake --jobs=1 CC="$(tc-getCC)" CFLAGS="${CFLAGS} -Demacs" || die
}

src_install() {
	local i

	dodir ${MY_BASEDIR}
	dodir /usr/share/man/man1
	make install LIBDIR="${D}${MY_BASEDIR}" BINDIR="${D}/usr/bin" \
		MANDIR="${D}/usr/share/man/man1" || die
	chmod -R go-w "${D}${MY_BASEDIR}"
	rmdir "${D}${MY_BASEDIR}/lock"

	dodir ${MY_LOCKDIR%/*}
	diropts -m0777
	keepdir ${MY_LOCKDIR}

	for i in emacsclient etags ctags; do
		mv "${D}"/usr/bin/${i}{,-emacs-${SLOT}} || die "mv ${i} failed"
	done
	mv "${D}"/usr/bin/emacs{,-${SLOT}} || die "mv emacs failed"
	mv "${D}"/usr/share/man/man1/emacs{,-emacs-${SLOT}}.1 || die
	dosym ../emacs/${PV}/info /usr/share/info/emacs-${SLOT}

	dodoc README PROBLEMS
}

pkg_postinst() {
	eselect emacs update ifunset
}

pkg_postrm() {
	eselect emacs update ifunset
}
