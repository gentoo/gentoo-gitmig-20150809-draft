# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monotone/monotone-0.17.ebuild,v 1.1 2005/03/24 08:18:37 dragonheart Exp $

inherit eutils flag-o-matic

DESCRIPTION="Monotone Distributed Version Control System"
HOMEPAGE="http://www.venge.net/monotone/"
SRC_URI="http://www.venge.net/monotone/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="${PV}"
KEYWORDS="x86 ~amd64"
#KEYWORDS ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64"

IUSE="nls doc"

RDEPEND=">=dev-libs/boost-1.31.0
	dev-libs/popt"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-3.3.3
	sys-devel/gettext"
#	doc? ( dev-lang/perl sys-apps/texinfo )"

src_compile() {

	# more aggressive optimizations cause trouble with the
	# crypto library
	# disable stack protector

	strip-flags
	# replace-flags -O3 -O2
	append-flags -fno-stack-protector-all -fno-stack-protector -fno-strict-aliasing

	econf `use_enable nls` || die
	emake || die "emake failed"
}

src_test() {
	make check
	einfo "test may fail on test 62"
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use doc ; then
		dodoc figures/*.pdf
	# Generate html docs - broken - missing images from figures directory
	#	emake html || die "emake html failed"
	#	dohtml -r html/*
	fi


	dodoc NEWS
	dodoc UPGRADE

	# Slotting
	OLD_N=${PN}
	NEW_N=${PN}-${PV}
	cd ${D}/usr
	mv bin/${OLD_N} bin/${NEW_N}
	mv share/info/${OLD_N}.info share/info/${NEW_N}.info
	mv share/man/man1/${OLD_N}.1 share/man/man1/${NEW_N}.1

	ewarn "For incopatibility reasons new monotone binary was renamed to \"${NEW_N}\""
	ewarn "If you want to use new features of ${PN} you have to upgrade your existing"
	ewarn "databases as described in /usr/share/doc/${P}/UPGRAGE.gz document."
}
