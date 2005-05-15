# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libfame/libfame-0.9.1.ebuild,v 1.11 2005/05/15 16:19:44 flameeyes Exp $

inherit flag-o-matic toolchain-funcs eutils

PATCHLEVEL="1"
DESCRIPTION="MPEG-1 and MPEG-4 video encoding library"
HOMEPAGE="http://fame.sourceforge.net/"
SRC_URI="mirror://sourceforge/fame/${P}.tar.gz
	http://digilander.libero.it/dgp85/gentoo/${PN}-patches-${PATCHLEVEL}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ia64 mips ppc ppc64 ~sparc ~x86"
IUSE="mmx sse"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}

	# Added in -r1
	EPATCH_EXCLUDE="04_all_pic.patch"
	if ! ( [ "$(gcc-major-version)" -eq "3" -a "$(gcc-minor-version)" -ge "4" ] || \
	[ "$(gcc-major-version)" -ge "4" ] ); then
		EPATCH_EXCLUDE="${EPATCH_EXCLUDE} 02_all_mmx-configure.patch 03_all_gcc34.patch"
	fi

	EPATCH_SUFFIX="patch" epatch ${WORKDIR}/${PV}

	# Do not add -march=i586, bug #41770.
	sed -i -e 's:-march=i[345]86 ::g' configure
}

src_compile() {
	econf $(use_enable mmx) $(use_enable sse) || die
	emake || die
}

src_install() {
	dodir /usr
	dodir /usr/lib

	einstall install || die
	dobin libfame-config

	insinto /usr/share/aclocal
	doins libfame.m4

	dodoc CHANGES README
	doman doc/*.3
}
