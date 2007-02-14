# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/emacs/emacs-18.59-r1.ebuild,v 1.1 2007/02/14 14:46:28 opfer Exp $

inherit eutils toolchain-funcs flag-o-matic alternatives

DESCRIPTION="The extensible self-documenting text editor"
HOMEPAGE="http://www.gnu.org/software/emacs/"
SRC_URI="mirror://gnu/old-gnu/emacs/${P}.tar.gz
	ftp://ftp.splode.com/pub/users/friedman/emacs/${P}-linux22x-elf-glibc21.diff.gz"

LICENSE="GPL-1"
SLOT="18"
KEYWORDS="~x86"
IUSE="X"

DEPEND="sys-libs/ncurses
	X? ( || ( x11-libs/libX11 virtual/x11 ) )"
PROVIDE="virtual/emacs virtual/editor"

MY_BASEDIR="/usr/share/emacs/${PV}"
MY_LOCKDIR="/var/lib/emacs/lock"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}/${P}-linux22x-elf-glibc21.diff"
	epatch "${FILESDIR}/${P}-unexelf.patch"
	epatch "${FILESDIR}/${P}-gentoo.patch"
	epatch "${FILESDIR}/${P}-gcc4.patch"
}

src_compile() {
	SANDBOX_ON=0

	# autoconf? What's autoconf? We are living in 1992. ;-)
	local arch
	case ${ARCH} in
		x86)   arch=intel386 ;;
		*)     die "Architecture ${ARCH} not supported" ;;
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

	# -O3 and -finline-functions cause segmentation faults at run time.
	filter-flags -finline-functions
	replace-flags -O[3-9] -O2
	strip-flags

	emake -j1 CC="$(tc-getCC)" CFLAGS="${CFLAGS} -Demacs" || die
}

src_install() {
	dodir ${MY_BASEDIR}
	dodir /usr/share/man/man1
	make install LIBDIR="${D}${MY_BASEDIR}" BINDIR="${D}/usr/bin" \
		MANDIR="${D}/usr/share/man/man1" || die
	chmod -R go-w "${D}${MY_BASEDIR}"
	rmdir "${D}${MY_BASEDIR}/lock"

	dodir ${MY_LOCKDIR%/*}
	diropts -m0777
	dodir ${MY_LOCKDIR}
	keepdir ${MY_LOCKDIR}

	for i in "${D}"/usr/bin/*; do
		mv ${i}{,.emacs-${SLOT}} || die "mv ${i} failed"
	done
	dosym emacs.emacs-${SLOT} /usr/bin/emacs-${SLOT}
	mv ${D}/usr/share/man/man1/emacs{,.emacs-${SLOT}}.1 || die

	dodoc README PROBLEMS
}

update-alternatives() {
	# Extract the suffix of the manpages to determine the correct
	# compression program.
	local suffix=$(echo /usr/share/man/man1/emacs.emacs-*.1*|sed 's/.*\.1//')

	# This creates symlinks for binaries and man page, so the correct
	# ones in a slotted environment can be accessed.
	for i in emacs emacsclient etags ctags; do
		alternatives_auto_makesym "/usr/bin/${i}" "/usr/bin/${i}.emacs-*"
	done

	alternatives_auto_makesym "/usr/share/man/man1/emacs.1${suffix}" \
		"/usr/share/man/man1/emacs.emacs-*.1${suffix}"
}

pkg_postinst() {
	update-alternatives
}

pkg_postrm() {
	update-alternatives
}
