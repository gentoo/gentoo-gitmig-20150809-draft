# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ispell/ispell-3.3.02.ebuild,v 1.1 2007/11/21 17:21:03 philantrop Exp $

inherit eutils multilib

PATCH_VER="0.2"
DESCRIPTION="fast screen-oriented spelling checker"
HOMEPAGE="http://fmg-www.cs.ucla.edu/geoff/ispell.html"
SRC_URI="http://fmg-www.cs.ucla.edu/geoff/tars/${P}.tar.gz
		mirror://gentoo/${P}-gentoo-${PATCH_VER}.diff.bz2"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND="sys-apps/miscfiles
		>=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}/${P}-gentoo-${PATCH_VER}.diff"

	sed -i -e "s:GENTOO_LIBDIR:$(get_libdir):" local.h.gentoo || die "setting libdir failed"
	cp local.h.gentoo local.h
}

src_compile() {
	emake config.sh || die

	# Fix config.sh to install to ${D}
	cp -p config.sh config.sh.orig
	sed \
		-e "s:^\(BINDIR='\)\(.*\):\1${D}\2:" \
		-e "s:^\(LIBDIR='\)\(.*\):\1${D}\2:" \
		-e "s:^\(MAN1DIR='\)\(.*\):\1${D}\2:" \
		-e "s:^\(MAN45DIR='\)\(.*\):\1${D}\2:" \
		< config.sh > config.sh.install

	emake || die "compilation failed"
}

src_install() {
	cp -p  config.sh.install config.sh

	# Need to create the directories to install into
	# before 'make install'. Build environment **doesn't**
	# check for existence and create if not already there.
	dodir /usr/bin /usr/$(get_libdir)/ispell /usr/share/info \
		/usr/share/man/man1 /usr/share/man/man5

	emake install || die "Installation Failed"

	rmdir "${D}"/usr/share/info || die "removing empty info dir failed"
	dodoc CHANGES Contributors README WISHES || die "installing docs failed"
	dosed "${D}"/usr/share/man/man1/ispell.1 || die "dosed failed"
}

pkg_postinst() {
	echo
	ewarn "If you just updated from an older version of ${PN} you *have* to re-emerge"
	ewarn "all your dictionaries to avoid segmentation faults and other problems."
	echo
}
