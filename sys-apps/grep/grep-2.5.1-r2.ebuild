# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grep/grep-2.5.1-r2.ebuild,v 1.2 2004/06/11 23:29:41 mr_bones_ Exp $

inherit gnuconfig flag-o-matic eutils

DESCRIPTION="GNU regular expression matcher"
HOMEPAGE="http://www.gnu.org/software/grep/grep.html"
SRC_URI="http://ftp.club.cc.cmu.edu/pub/gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${P}.tar.gz
	mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~s390"
IUSE="build nls perl static"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}
	perl? ( dev-libs/libpcre )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	if [ "${ARCH}" = "sparc" -a "${PROFILE_ARCH}" = "sparc" ] ; then
		epatch "${FILESDIR}/gentoo-sparc32-dfa.patch"
	fi
	epatch "${FILESDIR}/${PV}-manpage.patch"
	# Fix configure scripts to detect linux-mips
	gnuconfig_update
}

src_compile() {
	if use static || use perl ; then
		append-flags -static
		append-ldflags -static
	fi
	econf \
		$(use_enable nls) \
		$(use_enable perl perl-regexp) \
		--bindir=/bin \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# Override the default shell scripts... grep knows how to act
	# based on how it's called
	ln -sfn grep "${D}/bin/egrep" || die "ln egrep failed"
	ln -sfn grep "${D}/bin/fgrep" || die "ln fgrep failed"

	if use build ; then
		rm -rf "${D}/usr/share"
	else
		dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	fi
}
