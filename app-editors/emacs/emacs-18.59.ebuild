# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/emacs/emacs-18.59.ebuild,v 1.4 2004/07/30 18:55:15 usata Exp $

inherit eutils

DESCRIPTION="The extensible self-documenting text editor"
HOMEPAGE="http://www.gnu.org/software/emacs/"
SRC_URI="ftp://ftp.gnu.org/old-gnu/emacs/${P}.tar.gz
	ftp://ftp.splode.com/pub/users/friedman/patches/${P}-linux22x-elf-glibc2.diff.gz
	mirror://gentoo/${P}-gentoo.tar.gz"

LICENSE="GPL-1"
SLOT="1"
KEYWORDS="~x86"
IUSE="X"

DEPEND="sys-libs/ncurses
	X? ( virtual/x11 )"
PROVIDE="virtual/editor"

MY_BASEDIR="/usr/share/emacs/${PV}"
MY_LOCKDIR="/var/lib/emacs/lock"

# Do not use the sandbox, or the dumped Emacs will be twice as large
SANDBOX_DISABLED="1"

src_unpack() {
	unpack ${A}
	epatch ${P}-linux22x-elf-glibc2.diff
	epatch ${P}-unexelf.patch
	epatch ${P}-gentoo.patch
	epatch ${P}-gcc-gentoo.patch
}

src_compile() {
	# autoconf? What's autoconf? We are living in 1992. ;-)
	local arch
	case ${ARCH} in
		x86)   arch=intel386 ;;
		*)	   die "Architecture ${ARCH} not supported" ;;
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

	emake -j1 || die
}

src_install() {
	dodir ${MY_BASEDIR}
	dodir /usr/share/man/man1
	make install LIBDIR=${D}${MY_BASEDIR} BINDIR=${D}/usr/bin \
		MANDIR=${D}/usr/share/man/man1 || die
	chmod -R go-w ${D}${MY_BASEDIR}
	rmdir ${D}${MY_BASEDIR}/lock

	dodir ${MY_LOCKDIR%/*}
	diropts -m0777
	dodir ${MY_LOCKDIR}
	keepdir ${MY_LOCKDIR}

	for file in ${D}/usr/bin/*; do mv ${file} ${file}-${PV}; done
	mv ${D}/usr/share/man/man1/emacs.1 ${D}/usr/share/man/man1/emacs-${PV}.1
}
