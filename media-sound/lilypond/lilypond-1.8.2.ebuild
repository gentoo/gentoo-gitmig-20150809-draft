# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lilypond/lilypond-1.8.2.ebuild,v 1.4 2004/03/01 05:37:14 eradicator Exp $

IUSE="doc nopfa"

inherit gcc

MY_PV="v$(echo ${PV} | cut -d. -f1,2)"
DESCRIPTION="GNU Music Typesetter"
SRC_URI="http://www.lilypond.org/ftp/${MY_PV}/${P}.tar.gz"
HOMEPAGE="http://lilypond.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha x86"

DEPEND=">=dev-lang/python-2.2.3-r1
	>=dev-lang/perl-5.8.0-r12
	>=dev-util/guile-1.6.4
	>=sys-devel/bison-1.35
	>=app-text/tetex-1.0.7-r12
	>=sys-apps/texinfo-4.5
	>=sys-devel/flex-2.5.4a-r5
	!nopfa? ( >=app-text/mftrace-1.0.19 )
	doc? ( media-gfx/imagemagick
		>=app-text/mftrace-1.0.19
		virtual/ghostscript
		>=media-libs/netpbm-9.12-r4 )"

RDEPEND=">=dev-util/guile-1.6.4
	virtual/ghostscript
	>=app-text/tetex-1.0.7-r12
	>=dev-lang/python-2.2.3-r1"

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S}; epatch ${FILESDIR}/${P}-coreutils-compat.patch
	NOCONFIGURE=1 ./autogen.sh >/dev/null
}

src_compile() {
	# Remove ccache from the PATH since it can break compilation of
	# this package.  See bug 21305
	PATH="$(echo ":${PATH}:" | sed 's/:[^:]*ccache[^:]*:/:/;s/^://;s/:$//;')"

	addwrite /dev/stderr

	econf --build=${CHOST} || die "econf failed"
	emake || die "emake failed"

	if ! use nopfa; then
		addwrite /var/cache/fonts
		addwrite /usr/share/texmf/fonts
		addwrite /usr/share/texmf/ls-R
		make pfa-fonts || die "make pfa-fonts failed"
	fi

	if use doc; then
		addwrite /var/cache/fonts
		addwrite /usr/share/texmf/fonts
		addwrite /usr/share/texmf/ls-R
		make web || die "make web failed"
	fi
}

src_install () {
	# Remove ccache from the PATH since it can break compilation of
	# this package.  See bug 21305
	PATH="$(echo ":${PATH}:" | sed 's/:[^:]*ccache[^:]*:/:/;s/^://;s/:$//;')"

	BUILD_PFA="MAKE_PFA_FILES=1"
	use nopfa && BUILD_PFA=""
	einstall \
		lilypond_datadir=${D}/usr/share/lilypond \
		local_lilypond_datadir=${D}/usr/share/lilypond/${PV} \
		${BUILD_PFA}

	dodoc AUTHORS* COPYING ChangeLog DEDICATION NEWS* README.txt \
		ROADMAP THANKS VERSION *.el lilypond.words vimrc

	insinto /usr/share/lilypond/${PV}/buildscripts/out
	doins buildscripts/out/lilypond-profile \
		buildscripts/out/lilypond-login \
		buildscripts/out/clean-fonts

	use doc && dohtml -A txt,midi,ly,pdf,gz -r \
		Documentation input *.html *.png
}

pkg_postinst () {
	# Cleaning out old fonts is more appropriate in pkg_prerm, but we
	# also need to clean up after any lilypond installations which may
	# not have been installed via portage.
	. /usr/share/lilypond/${PV}/buildscripts/out/clean-fonts
}

pkg_prerm () {
	. /usr/share/lilypond/${PV}/buildscripts/out/clean-fonts
}
