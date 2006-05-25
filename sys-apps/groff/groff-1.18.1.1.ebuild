# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/groff/groff-1.18.1.1.ebuild,v 1.6 2006/05/25 21:55:35 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs

DEB_PATCH="${P/-/_}-12"
DESCRIPTION="Text formatter used for man pages"
HOMEPAGE="http://www.gnu.org/software/groff/groff.html"
SRC_URI="mirror://gnu/groff/${P}.tar.gz
	mirror://debian/pool/main/g/groff/${DEB_PATCH}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="X cjk"

DEPEND=">=sys-apps/texinfo-4.0"
PDEPEND=">=sys-apps/man-1.5k-r1"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# We lub Debian
	epatch "${WORKDIR}"/${DEB_PATCH}.diff
	epatch "${FILESDIR}"/${P}-deb-fix.patch

	# Fix the info pages to have .info extensions,
	# else they do not get gzipped.
	epatch "${FILESDIR}"/groff-1.18-infoext.patch

	# Do not generate example files that require us to
	# depend on netpbm.
	epatch "${FILESDIR}"/groff-1.18-no-netpbm-depend.patch

	# Make dashes the same as minus on the keyboard so that you
	# can search for it. Fixes #17580 and #16108
	# Thanks to James Cloos <cloos@jhcloos.com>
	epatch "${FILESDIR}"/${PN}-man-UTF-8.diff

	# Fix syntax error in pic2graph. Closes #32300.
	sed -i -e "s:groffpic_opts=\"-U\":groffpic_opts=\"-U\";;:" contrib/pic2graph/pic2graph.sh
}

src_compile() {
	local myconf=""

	# Fix problems with not finding g++
	export CC="$(tc-getCC)"
	export CXX="$(tc-getCXX)"

	case ${ARCH} in
		alpha)
			# -Os causes segfaults, -O is probably a fine replacement
			# (fixes bug 36008, 06 Jan 2004 agriffis)
			replace-flags -Os -O
			;;
		hppa)
			# -march=2.0 makes groff unable to finish the compile process
			export CFLAGS="${CFLAGS/-march=2.0/}"
			export CXXFLAGS="${CXXFLAGS/-march=2.0/}"
			;;
	esac

	myconf="${myconf} `use_enable cjk multibyte`"

	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=\${inforoot} \
		${myconf} || die

	# parallel build doesn't work
	emake -j1 || die

	# Only build X stuff if we have X installed, but do
	# not depend on it, else we get circular deps.
	if use X && [[ -n $(type -p xmkmf) ]] ; then
		cd ${S}/src/xditview
		xmkmf || die
		make depend all || die
	fi
}

src_install() {
	dodir /usr /usr/share/doc/${PF}/{examples,html}
	make prefix=${D}/usr \
		manroot=${D}/usr/share/man \
		inforoot=${D}/usr/share/info \
		docdir=${D}/usr/share/doc/${PF} \
		install || die

	if use X && [[ -n $(type -p xmkmf) ]] ; then
		cd ${S}/src/xditview
		make DESTDIR=${D} \
			BINDIR=/usr/bin \
			MANPATH=/usr/share/man \
			install \
			install.man || die
	fi

	#the following links are required for xman
	dosym eqn /usr/bin/geqn
	dosym tbl /usr/bin/gtbl
	dosym soelim /usr/bin/zsoelim

	cd ${S}
	dodoc BUG-REPORT COPYING ChangeLog FDL MORE.STUFF NEWS \
		PROBLEMS PROJECTS README REVISION TODO VERSION
}
