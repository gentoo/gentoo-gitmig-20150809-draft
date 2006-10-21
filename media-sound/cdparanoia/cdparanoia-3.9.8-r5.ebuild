# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdparanoia/cdparanoia-3.9.8-r5.ebuild,v 1.1 2006/10/21 23:06:09 flameeyes Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="2.1"

inherit eutils flag-o-matic libtool toolchain-funcs versionator autotools

MY_P=${PN}-III-alpha$(get_version_component_range 2-3)
S=${WORKDIR}/${MY_P}

DESCRIPTION="an advanced CDDA reader with error correction"
HOMEPAGE="http://www.xiph.org/paranoia/"
SRC_URI="http://www.xiph.org/paranoia/download/${MY_P}.src.tgz
	mirror://gentoo/${P}-fbsd-2.patch.bz2"

IUSE="kernel_linux"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# cdda_paranoia.h should include cdda_interface_h, else most configure
	# scripts testing for support fails (gnome-vfs, etc).
	epatch "${FILESDIR}/${P}-include-cdda_interface_h.patch"
	epatch "${FILESDIR}/${P}-toc.patch"
	epatch "${FILESDIR}/${P}-identify_crash.patch"
	epatch "${FILESDIR}/${PV}-gcc34.patch"

	# if libdir is specified, cdparanoia causes sandbox violations, and using
	# einstall doesnt work around it. so lets patch in DESTDIR support
	epatch "${FILESDIR}/${P}-use-destdir.patch"

	epatch "${FILESDIR}/${P}-respectflags-pio.patch"

	epatch "${DISTDIR}/${P}-fbsd-2.patch.bz2"
	# Fix makefiles for parallel make
	epatch "${FILESDIR}/${P}-parallel-fpic-fbsd.patch"

	# Use directly the same exact patch as flex as it works
	epatch "${FILESDIR}/flex-configure-LANG.patch"

	# Let portage handle the stripping of binaries
	sed -i -e "/strip cdparanoia/d" Makefile.in

	# Fix Makefiles for parallel building. Bug #136128.
	sed -i \
		-e "s/^lib:	$/lib:	\$(OFILES)/" \
		-e "s/^slib:	$/slib:	\$(OFILES)/" \
		-e "/\$(MAKE) lessmessy$/d" \
		interface/Makefile.in paranoia/Makefile.in

	mv configure.guess config.guess
	mv configure.sub config.sub
	sed -i -e '/configure.\(guess\|sub\)/d' "${S}"/configure.in

	eautoconf
	elibtoolize
}

src_compile() {
	tc-export CC AR RANLIB
	append-flags -I"${S}/interface"

	econf || die
	emake OPT="${CFLAGS}" || die
}

src_install() {
	dodir /usr/{bin,lib,include} /usr/share/man/man1
	emake DESTDIR="${D}" install || die
	dodoc FAQ.txt README
}
