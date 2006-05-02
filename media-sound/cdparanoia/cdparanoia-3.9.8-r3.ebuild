# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdparanoia/cdparanoia-3.9.8-r3.ebuild,v 1.8 2006/05/02 19:18:30 corsair Exp $

inherit eutils flag-o-matic gnuconfig linux-info

MY_P=${PN}-III-alpha9.8
S=${WORKDIR}/${MY_P}

DESCRIPTION="an advanced CDDA reader with error correction"
HOMEPAGE="http://www.xiph.org/paranoia/"
SRC_URI="http://www.xiph.org/paranoia/download/${MY_P}.src.tgz
	mirror://gentoo/${P}-SG_IO-patches.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~sparc ~x86"

src_unpack() {
	unpack ${A}
	cd ${S}

	# cdda_paranoia.h should include cdda_interface_h, else most configure
	# scripts testing for support fails (gnome-vfs, etc).
	epatch ${FILESDIR}/${P}-include-cdda_interface_h.patch
	epatch ${FILESDIR}/${P}-toc.patch
	epatch ${FILESDIR}/${P}-identify_crash.patch
	epatch ${FILESDIR}/${PV}-gcc34.patch

	# if libdir is specified, cdparanoia causes sandbox violations, and using
	# einstall doesnt work around it. so lets patch in DESTDIR support
	epatch ${FILESDIR}/${P}-use-destdir.patch

	# Apply Red Hat's SG_IO patches see bug #118189 for more info
	if kernel_is ge 2 6 15; then
		EPATCH_SOURCE="${WORKDIR}/patches" EPATCH_SUFFIX="patch" epatch
		epatch ${FILESDIR}/${P}-respectflags-sgio.patch
	else
		epatch ${FILESDIR}/${P}-respectflags-pio.patch
	fi

	# Use directly the same exact patch as flex as it works
	epatch "${FILESDIR}/flex-configure-LANG.patch"

	# Let portage handle the stripping of binaries
	sed -i -e "/strip cdparanoia/d" Makefile.in

	ln -s configure.guess config.guess
	ln -s configure.sub config.sub
	gnuconfig_update
	rm config.{guess,sub}

	elibtoolize
}

src_compile() {
	append-flags -I${S}/interface
	econf || die
	make OPT="${CFLAGS}" || die
}

src_install() {
	dodir /usr/{bin,lib,include} /usr/share/man/man1
	make DESTDIR=${D} install || die
	dodoc FAQ.txt README
}
