# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/lilypond/lilypond-1.6.9.ebuild,v 1.2 2003/05/27 09:06:31 jje Exp $

IUSE="doc"

inherit gcc

MY_PV="v$(echo ${PV} | cut -d. -f1,2)"
DESCRIPTION="GNU Music Typesetter"
SRC_URI="http://www.lilypond.org/ftp/${MY_PV}/${P}.tar.gz"
HOMEPAGE="http://lilypond.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=dev-lang/python-2.2.1-r2
	>=dev-lang/perl-5.6.1-r6
	>=dev-util/guile-1.4-r3
	>=sys-devel/bison-1.35
	>=app-text/tetex-1.0.7-r12
	>=sys-apps/texinfo-4.2-r5
	>=sys-devel/flex-2.5.4a-r5
	doc? ( >=app-text/mftrace-1.0.8
		>=app-text/ghostscript-7.05.5
		>=media-libs/netpbm-9.12-r2 )"

RDEPEND=">=dev-util/guile-1.4-r3
	>=app-text/ghostscript-7.05.5
	>=app-text/tetex-1.0.7-r10
	>=dev-lang/python-2.2.1-r2"

src_compile() {
	# See http://lilypond.org/stable/Documentation/topdocs/out-www/INSTALL.html
	if [ "`gcc-major-version`" -eq "2" ]; then
		# Verified by agriffis 03 Dec 2002 using
		# gcc-2.95.3-r7 with flex-2.5.4a-r5
		# (i.e. Gentoo 1.2)
		./configure --build=${CHOST} --prefix=/usr || die "configure failed"
		emake || die "emake failed"
	elif [ "`gcc-major-version`" -eq "3" -a "`gcc-minor-version`" -ge "2" ]; then
		# Verified by agriffis 03 Dec 2002 using
		# gcc-3.2.1 with flex-2.5.4a and flex-2.5.23
		./configure --build=${CHOST} --prefix=/usr || die "configure failed"
		# Fix std::cerr problem in flex 2.5.4a and 2.5.23
		make -C lily out/lexer.cc
		perl -i -pe 's/\scerr\s/ std::cerr /g' lily/out/lexer.cc
		emake || die "emake failed"
	else
		eerror "Unsupported GCC version, 2.95 and 3.2 are supported"
		die
	fi
	use doc && (make prefix=${D}/usr \
			datadir=${D}/usr/share \
			lilypond_data=${D}/usr/share/lilypond \
			local_lilypond_datadir=${D}/usr/share/lilypond/${PV} \
			topdir=${D}/usr \
			web-doc || die "make web-doc failed")
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		datadir=${D}/usr/share \
		lilypond_datadir=${D}/usr/share/lilypond \
		local_lilypond_datadir=${D}/usr/share/lilypond/${PV} \
		install || die "make install failed"
	dodoc AUTHORS* COPYING ChangeLog DEDICATION NEWS README.txt \
		ROADMAP THANKS VERSION *.el
	insinto /usr/share/lilypond/${PV}/buildscripts/out
	doins buildscripts/out/lilypond-profile \
		buildscripts/out/lilypond-login \
		buildscripts/out/clean-fonts
	use doc && dohtml -A ly,pdf,gz -r Documentation *.html *.png
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
